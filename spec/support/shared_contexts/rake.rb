require "rake"

shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:project_directory) { File.join(File.dirname(__FILE__), '../../../') }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "tasks/#{task_name.split(":").first}" }
  subject         { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject do |file|
      file == File.join(project_directory, "#{task_path}.rake").to_s
    end
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(
      task_path, [project_directory], loaded_files_excluding_current_rake_file
    )
    Rake::Task.define_task(:environment)
  end
end
