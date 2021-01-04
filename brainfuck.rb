class BrainFuck
    attr_reader :output
    def initialize
        @tape = Array.new(10000){0}
        @ptr = 0
        @pc = 0
        @output = ""
    end     
    def interpreter(file)
        code = File.open(file) {|f|f.read}.split("")
        while @pc < code.length
            case code[@pc]
            when ">" then
                @ptr+=1
            when "<" then
                @ptr-=1
            when "+" then
                @tape[@ptr]+=1
            when "-" then
                @tape[@ptr]-=1
            when "." then
                @output+=@tape[@ptr].chr
            when "," then
                @tape[@ptr] = gets.chomp.ord
            when "[" then
                if @tape[@ptr] == 0
                    nest = 0
                    while true
                        @pc+=1
                        if code[@pc] == '['
                            nest += 1
                        end
                        if code[@pc] == ']' && nest == 0
                            break
                        end
                        if code[@pc] = ']'
                            nest-=1
                        end
                    end
                end
            when "]" then
                if @tape[@ptr] != 0
                    nest = 0
                    while true
                        @pc-=1
                        if code[@pc] == ']'
                            nest+=1
                        end
                        if code[@pc] == '[' &&  nest == 0
                            break
                        end
                        if code[@pc] == '['
                            nest -=1
                        end
                    end
                end
            end
            @pc+=1
        end
    end
end

if ARGV.length > 0
    bf = BrainFuck.new
    bf.interpreter(ARGV[0])
    puts bf.output
else
    puts "brainfuck.rb program"
end