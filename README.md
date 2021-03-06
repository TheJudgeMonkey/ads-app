[![CircleCI](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main.svg?style=svg)](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main) [![Heroku](https://pyheroku-badge.herokuapp.com/?app=my-ads-app&style=<STYLE>)](https://my-ads-app.herokuapp.com/)

# ADS-APP

[Project on heroku](https://my-ads-app.herokuapp.com/)

## Setup 

### Prerequisites
- node 16.8.0
- ruby 3.0.0
- PostgreSQL 12.8.0
- redis 5.0.7

You will need RAILS_MASTER_KEY to use cloudinary, please contact me to get it. Otherwise, it's not going to work. 


### For all systems

```bash
git clone git@github.com:TheJudgeMonkey/ads-app.git
cd ads-app
gem install bundler:2.2.26
bundle
yarn
bundle exec rails db:setup
bundle exec rails s
```

## Cron jobs

Heroku does not support gem `whenever` so I had to use Heroku Scheduler to setup cron jobs.
Cron jobs generated by `whenever` look like this:

```bash
$ crontab -l


# Begin Whenever generated tasks for: /home/stas/twinslash/ads-app/config/schedule.rb at: 2021-09-05 01:16:26 +0300
0 0 * * * /bin/bash -l -c 'cd /home/stas/twinslash/ads-app && RAILS_ENV=production bundle exec rake publish_advertisements --silent'

50 23 * * * /bin/bash -l -c 'cd /home/stas/twinslash/ads-app && RAILS_ENV=production bundle exec rake archive_advertisements --silent'

# End Whenever generated tasks for: /home/stas/twinslash/ads-app/config/schedule.rb at: 2021-09-05 01:16:26 +0300
```

Cron jobs for Heroku Scheduler are done via Heroku UI so no output is available, but it works exactly the same way.
