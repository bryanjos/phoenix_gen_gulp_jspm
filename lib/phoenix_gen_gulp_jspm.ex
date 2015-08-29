defmodule Mix.Tasks.Phoenix.Gen.Gulp.Jspm do
  use Mix.Task

  @package_json_template Path.join(__DIR__, "templates/package.json")
  @gulpfile_template Path.join(__DIR__, "templates/gulpfile.js")
  @jspm_config_template Path.join(__DIR__, "templates/config.js")
  @brunch_watcher_matcher ~r|watchers: \[(.*?)\]\n|
  @gulp_watcher ~s|watchers: [node: ["node_modules/gulp/bin/gulp.js", "watch", "--stdin"]]\n|
  @require_js_matcher ~r|\s*<script src="<%= static_path\(@conn, "\/js\/app.js"\) %>"><\/script>\n|
  @static_list_matcher ~r|\s*only: ~w\(css fonts images js favicon.ico robots.txt\)\n|
  @socket_import_matcher ~r|\s*import {Socket} from "deps/phoenix/web/static/js/phoenix"\n|

  @shortdoc "Replace Brunch with Gulp. Uses babel, cssnext, and jspm"


  @doc """
  Removes Brunch configuration files (if they exist)
  and replaces them with a basic Gulp configuration.
  """
  def run([app_name]) do
    replace_package_json!
    clean_node_modules!
    clean_priv_static!
    create_gulp_config!
    add_jspm_config!
    update_static_list!(app_name)
    create_static_files!
    replace_script_tag_with_system_js!
    add_gulp_to_watchers_list!
    done!
  end

  def run(_args) do
    print("USAGE: mix phoenix.gen.gulp <<app_name>>")    
  end

  defp replace_package_json! do
    print("Replacing package.json..")
    File.rm_rf! "package.json"
    File.cp! @package_json_template, "package.json"
  end

  defp clean_node_modules! do
    print("Cleaning node_modules..")
    File.rm_rf! "node_modules"
  end

  defp clean_priv_static! do
    print("Cleaning priv/static..")
    File.rm_rf! "priv/static/css"
    File.rm_rf! "priv/static/js"
    File.mkdir_p! "priv/static/js"
  end

  defp create_gulp_config! do
    print("Replacing brunch-config.js with gulpfile.js..")
    File.rm_rf! "brunch-config.js"
    File.cp! @gulpfile_template, "gulpfile.js"
  end

  defp add_jspm_config! do
    print("Adding config.js in priv/static")
    File.cp! @jspm_config_template, "priv/static/config.js"
  end

  defp update_static_list!(app_name) do
    print("Updating static list to include jspm_packages and config.js")
    File.read!("lib/#{app_name}/endpoint.ex")
    |> String.replace(@static_list_matcher, """

        only: ~w(css fonts images js favicon.ico robots.txt jspm_packages config.js)
    """, global: false)
    |> (&File.write!("lib/#{app_name}/endpoint.ex", &1)).()
  end

  defp create_static_files! do
    print("Creating static files..")
    File.mkdir_p! "web/static/css"
    File.mkdir_p! "web/static/js"
    File.touch! "web/static/css/app.css"
    File.touch! "web/static/js/app.js"
    File.touch! "web/static/js/phoenix.js"

    phoenix_html_js = File.read!("deps/phoenix_html/web/static/js/phoenix_html.js")
    phoenix_html_js = "\/\/ import socket from \"./socket\"\n\n" <> phoenix_html_js <> "\n" 
    File.write!("web/static/js/app.js", phoenix_html_js)

    phoenix_js = File.read!("deps/phoenix/web/static/js/phoenix.js")
    File.write!("web/static/js/phoenix.js", phoenix_js)

    File.read!("web/static/js/socket.js")
    |> String.replace(@socket_import_matcher, "\nimport {Socket} from \"./phoenix\";\n", global: false)
    |> (&File.write!("web/static/js/socket.js", &1)).()
  end

  defp replace_script_tag_with_system_js! do
    print("Updating the script tag to use system.js")
    File.read!("web/templates/layout/app.html.eex")
    |> String.replace(@require_js_matcher, """

    <script src="<%= static_path(@conn, "/jspm_packages/system.js") %>"></script>
    <script src="<%= static_path(@conn, "/config.js") %>"></script>
    <script>
      System.import('js/app');
    </script>
    """, global: false)
    |> (&File.write!("web/templates/layout/app.html.eex", &1)).()
  end

  defp add_gulp_to_watchers_list! do
    print("Setting gulp as a watcher..")
    File.read!("config/dev.exs")
    |> String.replace(@brunch_watcher_matcher, @gulp_watcher, global: false)
    |> (&File.write!("config/dev.exs", &1)).()
  end

  defp done! do
    print("ALL DONE!")
    print("please run both 'npm install' and 'jspm install'")
  end

  defp print(message) do
    Mix.shell.info [:green, message]
  end

end
