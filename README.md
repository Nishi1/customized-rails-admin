# Sweep Media

Sweep Media is an automated reporting system for the coaches that will pull directly from the athlete reports to give the coaches a full overview of each student athletes
completion and their results and allow us to provide additional feedback.

# Technologies
  - Rails
  - Mysql  
  
Project revisions are managed in **sweep-media** repository on private server with [GIT]( http://gitlab.zapbuild.com/zapbuild/sweep-media.git ) and issues are tracked on [Redmine](http://redmine.zapbuild.com/projects/sweepmedia/issues).

### Installation


Sweep Media requires [Ruby](https://www.ruby-lang.org/en/documentation/installation/) v2.4.0  and Rails 5.2.3 to run.

Define environment variables used in project. `change values according to current server`
```sh
$ export SWEEPMEDIA_DB_NAME='sweep_media'
$ export SWEEPMEDIA_DB_USER='sweep_media'
$ export SWEEPMEDIA_DB_PASS='tEZJgKUyj9hQ'
$ export SWEEPMEDIA_DOMAIN='sweep-media.zapbuild.com'
$ export SWEEPMEDIA_PORT='3000'
$ export SWEEPMEDIA_PROTOCOL='http://'


```
Clone the git repository and install packages.
```sh
$ git clone "CLONE_URL"
$ cd sweep-media
$ bundle install
```
Setup database and start the rails.
```sh
$ rake db:create
$ rake db:migrate
$ rake db:seed
$ rails s
```
