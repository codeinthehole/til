---
title: "BBC Sounds only works on Alexa if the language setting is UK English"
date: "2021-01-07T15:47:57+00:00"
tags: ["Alexa"]
---

Was puzzled as to why:

> Alexa, play BBC radio four

wasn't triggering the BBC Sounds skill on a new 4th Generation Echo.

Turns out the problem was the default language was "English (US)" when it should
have been "English (UK)".

This is noted in
[the BBC docs](https://www.bbc.co.uk/usingthebbc/account/the-bbc-on-voice-devices/).

{{< figure src="/images/bbc-sounds-on-alexa.png" title="" caption="" alt="BBC Sounds on Alexa" >}}
