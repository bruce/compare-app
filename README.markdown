# Ruby 1.9 Comparison Application

A simple application use to run chunks of code through Ruby 1.8 and 1.9, and
compare exit codes, running time, and output.

## Author

Bruce Williams <bruce@codefluency.com>; http://codefluency.com

## Caveats

*IMPORTANT*: This application is *specifically* used to run arbitrary,
browser-entered code through Ruby 1.8 and 1.9. If you host this application
and allow public access, you are doing so AT YOUR OWN RISK. And you're also
certifiably insane.

ONLY, *I REPEAT* ONLY, RUN THIS APPLICATION LOCALLY.  THIS IS A PERSONAL,
LEARNING/EXPLORATORY TOOL.

# Dependencies

1. The `open4` and `RedCloth` gems (`sudo rake gems:install`)
2. Rails 2.3+

## Installation

Get a copy of the source, and modify `config/database.yml` to your liking.

    sudo rake gems:install
    rake db:create
    rake db:migrate
    ruby script/server
    
You'll probably want to modify `EXECUTABLES` in `config/initializers/executables.rb` to point to the Ruby implementations you want to run.

Go forth and compare!

## Limitations

1. No timeouts enforced. If you write a never-ending loop, you'll get one. Feel free to contribute fixes. 
2. No output limits enforced. The application will try to grab and store any output, so be careful here. Feel free to contribute fixes.
3. Benchmarks are not "scientific" by any means.  Take time comparisons with a seriously large chunk of salt.  Feel free to contribute fixes.

This application isn't smart, and could use some additional work, as noted above. Drop me a note if you'd like to contribute any changes.
   
## LICENSE

The MIT License

Copyright (c) 2008 Bruce R. Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
      

  
