---
title: "How to get uWSGI's `log-route` to support regular expressions"
date: "2023-07-28T12:26:19+01:00"
tags: ["uWSGI"]
---

I was trying to get uWSGI to log in JSON, following [this nicely laid-out
guide][blogpost]; but it wasn't working.

This is the `uwsgi.ini` file I was using:

```dosini
# Define a logger for application messages. These will be in JSON already and so
# we use a regex to route lines that start with a `{` and simply print the
# message as is.
logger = djangologger stdio
log-route = djangologger ^{.*$
log-encoder = format:djangologger ${msg}

# Define a logger for uWSGI *server* logs. We use a regex to route lines
# that don't start with a `{`. We format them as JSON using the `json` encoder.
logger = uwsgilogger stdio
log-route = uwsgilogger ^((?!\{).)*$
log-encoder = json:uwsgilogger {"time": "${micros}", "message": "${msg}"}

# Define a logger for uWSGI *request* logs.
logger-req = stdio
log-format = {"source": "uwsgi", "type": "request", "method": "%(method)", "path": "%(uri)", "user_agent": "%(uagent)", "duration_in_ms": %(msecs), "referer": "%(referer)", "host": "%(host)", "time": %(time), "remote_ip": "%(addr)"}
log-encoder = nl
```

The request logs would be JSON formatted but not the server logs you see at
start-up and shutdown.

The clue was there in the output though:

```txt
!!! no internal routing support, rebuild with pcre support !!!
```

So, for the record, the appropriate system packages required to install uWSGI
with PCRE support are:

```sh
apt-get install gcc libpcre3-dev
```

Running the above then

```sh
pip install uwsgi
```

will ensure your uWSGI server logs are JSON encoded (after the initial
`[log-encoder]` lines at least):

```txt
[uWSGI] getting INI configuration from uwsgi.ini
2023-07-28T15:42:32 - [log-encoder] registered format:applogger ${msg}
2023-07-28T15:42:32 - [log-encoder] registered nl:applogger
2023-07-28T15:42:32 - [log-encoder] registered json:uwsgilogger {"time":"${strftime:%Y-%m-%dT%H:%M:%S}", "event": "uwsgi.system", "message":"${msg}"}
2023-07-28T15:42:32 - [log-encoder] registered nl
{"time":"2023-07-28T15:42:32", "message":"*** Starting uWSGI 2.0.21 (64bit) on [Fri Jul 28 15:42:32 2023] ***"}
{"time":"2023-07-28T15:42:32", "message":"compiled with version: 12.2.0 on 28 July 2023 09:13:25"}
{"time":"2023-07-28T15:42:32", "message":"os: Linux-5.10.76-linuxkit #1 SMP Mon Nov 8 10:21:19 UTC 2021"}
```

[blogpost]: https://blog.rama.io/json-logging-with-uwsgi
