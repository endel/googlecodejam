module GoogleCodeJam
  class Runner

    def initialize(options={})
      instance = self.initialize_from_path(options[:source])

      input = open(options[:input]).read
      options[:output] ||= options[:input].gsub('.in', ".out")

      num, *lines = input.split("\n")
      output = lines.each_with_index.inject("") do |r, (n, i)|
        begin
          r + (i+1==1 ? "" : "\n") + "Case ##{i+1}: #{instance.run(n)}"
        rescue => e
          puts e.backtrace
          raise "Line: #{n.inspect}"
        end
      end.strip

      File.open(options[:output], 'w+') {|f| f.write(output) }
      options
    end

    protected
      def initialize_from_path(path)
        full_path = File.expand_path(path)
        raise "'#{full_path}' not found." unless require full_path
        filename = File.basename(path, File.extname(path))
        klass_name = filename.split('_').map {|w| w.capitalize}.join

        if Object.const_get(klass_name)
          klass = Object.const_get(klass_name)
        end rescue nil

        if klass
          instance = klass.new
          raise "#{instance.name} must implement #run method." unless instance.respond_to?(:run)
          instance
        else
          puts "Error: '#{path}' is expected to define '#{klass_name}'"
          abort
        end
      end
  end
end
