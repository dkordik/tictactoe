def clear()
  system("clear")
end

def colorize(text,color)
  "\e[#{color}m#{text}\e[0m"
end

def matrix_type(msg)
  STDOUT.sync = true
  msg.split('').each do |chr|
    print chr
    sleep(0.01)
  end
end