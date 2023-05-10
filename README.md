# This is a Helper, not a Solver

It tries to present you with the most useful words based on how many of the letters that are used by the possible solutions appear in those words. Near the end (when there are less than 20 possible solutions), it will attempt to give you a "bridge word" - one which has letters which are shared among the remaining solutions - so that you can narrow your choices the most.

* Ruby version 2.6.8

* Database creation
  * bundle exec rake db:create:all

* Database initialization
  * bundle exec rake db:migrate

Recently, Wordle changed from a static set of solutions (about 2,300 of them) to being "curated" by a person at the New York Times who chooses the next month's solutions from the pool of *all* allowed words (about 14,500). However, they have stated that they won't use "simple plurals." I added the concept of an "Ignored Word" which is one that won't be considered in the calculations for the best guesses, but will be displayed (just in case it happens to be the real solution). To add all of the "simple plurals" to that ignored list, start up the Rails console ('rails c') and run `IgnoredWord.populate_simple_plurals`. In addition, when you are in the UI, you can click the "ignore" link next to any word you don't think will ever be a solution (like "auloi", plural form of an ancient Greek wind instrument; not very commonly used). If you made a mistake, or it turns out one of those ended up being the solution (oops!), click the "unignore" link next to the word to start considering it again.
