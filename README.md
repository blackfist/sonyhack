# Sony Hack Attribution Generator

So there are a lot of conflicting stories out there about who hacked Sony and
a lot of people are being asked to weigh in with their opinion. Do you need a
quick story you can pull out of your butt to explain the Sony hack at a party
or job interview?

Just fire this bad boy up and read the output.

## Dependencies
The Project is written to use Sinatra and since I normally write in Rails, I
threw in a content_for tag that Sinatra doesn't support. Rather than rewrite
the app, I just used the sinatra-contrib gem. So you need to install that too.

    gem install sinatra
    gem install sinatra-contrib

## How to run the generator

    ruby server.rb
    [2014-12-31 09:28:15] INFO  WEBrick 1.3.1
    [2014-12-31 09:28:15] INFO  ruby 2.1.3 (2014-09-19) [x86_64-darwin13.0]
    == Sinatra/1.4.5 has taken the stage on 4567 for development with backup from WEBrick
    [2014-12-31 09:28:15] INFO  WEBrick::HTTPServer#start: pid=5627 port=4567

Then point your browser at localhost:4567
