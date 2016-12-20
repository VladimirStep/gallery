desc "Uploads files from given directory"
task :pictures, [:path] => :environment do |task, args|
  if args.none?
    puts "No arguments given.\nUsage: rake pictures[path/to/your/files]"
  else
    given_directory = args.path.to_s
    if Dir.exist?(given_directory)
      Dir.chdir(given_directory)
      source = Rake::FileList.new("*") do |item|
        item.exclude("~*")
        item.exclude(".*")
      end

      source.each do |dir|
        if Dir.exist?(dir)
          cat = Category.new(category_name: dir.to_s)
          if cat.save
            files = Rake::FileList.new("#{dir.to_s}/*")
            files.each do |file|
              pic = cat.pictures.new(image: File.open(file.to_s))
              pic.save!
            end
          end
        end
      end
    else
      puts "This is not a directory"
    end
  end
end