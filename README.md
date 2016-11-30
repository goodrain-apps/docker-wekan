# docker-wekan
docker build wekan

Run Wekan?
----------
    wekan dependency mongo, so first run mongo
    <code>
    docker run -d --name wekan-mongo mongo
    </code>
    next you need set SITE_URL and MAIL_FROM.
    if you donot, default setting will be used.
    <code>
    docker run -d --link "wekan-mongo:mongo" -e "ROOT_URL=http://wekan.goodrain.com" -e "MAIL_FILE=admin@wekan.goodrain.com" wekan
    </code>
