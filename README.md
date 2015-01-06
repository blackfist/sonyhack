# Sony Hack Attribution Generator

So there are quite a few conflicting stories out there about who hacked Sony and
many "experts" being asked to weigh in with their opinion. Do you need a
quick story you can pull out of your hat to explain the Sony hack at a party
or job interview?

Just fire this bad boy up and read the output.

## Are you just making stuff up?

It is not "made-up" per se. This attribution generator uses aggregated information
from the [VCDB](http://vcdb.org/) and [DBIR](http://www.verizonenterprise.com/DBIR/)
databases from Verizon that accumulate private and public data
breach information from a great number of companies around the worlds.

It uses the aggregated likelihood of the types of breach actors (i.e. "internal",
"external" or "partner"), and more detailed information about the source of the
breach actor (such as "organized crime", "activitst", "state-sponsored", etc.).
You can review (and tweak if you like) the breach info on [freqs.csv](https://github.com/blackfist/sonyhack/blob/master/freqs.csv).

We also do a similar likelihood estimation on reported origin countries of the attacks.
Vou can also review this information on [countries.csv](https://github.com/blackfist/sonyhack/blob/master/countries.csv).

Since it is unlikely that any further evidence on this case will not be released
to the public, it is really a guessing game now. At the very least, you can now have
some data-driven guesses to share your own attribution story to the press.

Most of the details, quotes and IOCs are purely made up for flavor. If we have
quoted you as a real person, we probably like you and think you made good arguments
against the original attribution.

# Technical deployment details

## Dependencies
The Project is written to use Sinatra and since I normally write in Rails, I
threw in a content_for tag that Sinatra doesn't support. Rather than rewrite
the app, I just used the sinatra-contrib gem. So you need to install that too.
Oh and facets so I could get the `titlecase` function. The easiest thing to do
is just run

    bundle install

to get all the dependencies installed.

## How to run the generator

    ruby server.rb
    [2014-12-31 09:28:15] INFO  WEBrick 1.3.1
    [2014-12-31 09:28:15] INFO  ruby 2.1.3 (2014-09-19) [x86_64-darwin13.0]
    == Sinatra/1.4.5 has taken the stage on 4567 for development with backup from WEBrick
    [2014-12-31 09:28:15] INFO  WEBrick::HTTPServer#start: pid=5627 port=4567

Then point your browser at localhost:4567
