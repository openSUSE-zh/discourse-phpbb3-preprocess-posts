discourse-phpbb3-preprocess-posts

------

Discourse's bbcode to markdown conversion is done at importing, and it creates many sidekiq jobs that will finish in days.

It significantly decreases the response speed of your site, causing high CPU/memory/disk IO usages.

So I invent this, we pre-process the phpbb3 bbcode posts in your backup mysql server, that is, we convert it in advance, so they're ready to be imported and serve immediately.
