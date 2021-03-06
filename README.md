![icon](https://github.com/thecoffman/indexmarks/raw/master/ext/icon.png)
#IndexMarks
###Because a bookmark titled "Joe's Blog" just isn't that useful.

What?
---------------

Ever have trouble finding back those nginx docs you bookmarked? That really great blog post about organization? If you're like me it happens all the time. All my bookmarks are tossed in one folder and its hard to tell what they are from the title alone. That's why I built IndexMarks - it provides indexed full text search for your bookmarks: not just the titles but the page contents themselves! IndexMarks works as a Chrome plugin in conjunction with a small Sinatra server that runs locally on your machine.


Installation - Development/Testing
-----

If you don't want to install IndexMarks for everyday use or would like to be able to debug or hack on it set up is super simple. Requires ruby 1.9.2.

1. Pull this repo

2. Make sure you have the dependencies installed. You'll need the following gems: `sinatra, json, sanitize, sdsykes-ferret`

3. Navigate to the `bin` directory and `./indexmarks`

4. Open Chrome. Go to Extensions -> Developer -> Load Unpacked Extension and select the `ext` directory from this repo

5. Continue bookmarking things like normal - but when you want to search, click the newly added IndexMarks icon in Chrome!

6. Note that the first time you start IndexMarks, it will spider your bookmark tree and build the initial index. This process can take several minutes depending on how many things you have bookmarked. Be patient, this will only happen once! The server must be running the first time you start the extension or the indexing will not take place.


Installation - For Everyday Use
-----
This will entail installing the binary packaged extension and setting the server up as an OSX background launch item. Rakefile incoming.

Credits
--------

- Icon - [Evan Brooks' "Token" Icon Set](http://brsev.com)

- Inspiration - [Defunkt's dotjs](http://defunkt.io/dotjs/) for the idea of combining a Chrome extension with a locally run server. (And for his installation rakefile which I intend on "borrowing" from for the IndexMarks installer)


Preview
------------
![preview](http://f.cl.ly/items/1f2E3T3A2x0R1V2D083Y/Screen%20shot%202011-07-21%20at%209.22.19%20AM.png)

Planned Features
------------
Everything works as is - however I would like to highlight the the search terms in the results and provide more intelligent text snippets rather than just the first few hundred characters. Extensions for other browsers would also increase its usefulness. Additionally, weighting search results based on title or h1 tags would probably improve the relevancy of the results.

Author
-------

[Adam Coffman](http://thecoffman.com) :: [coffman.adam@gmail.com](mailto:coffman.adam@gmail.com) :: [@thecoffman](http://twitter.com/thecoffman)
