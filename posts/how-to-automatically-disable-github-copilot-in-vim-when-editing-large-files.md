---
title:
  "How to automatically disable Github Copilot in Vim when editing large files"
date: "2023-01-06T09:21:18+00:00"
tags: ["Vim", "Github Copilot"]
---

Since installing [`vim-copilot`][vim_copilot], editing large files had become
noticeably slow. Profiling[^1] a simple insert-mode operation confirmed my
suspicions:

[^1]:
    See my [debugging Vim by example][profiling] blog post for more info on how
    to debug performance problems.

```txt
FUNCTIONS SORTED ON TOTAL TIME
count  total (s)   self (s)  function
    3   4.460965   0.000162  <SNR>36_Trigger()
    3   4.460803   0.000084  copilot#Suggest()
    3   4.460719   0.000295  copilot#Complete()
    3   4.451540   0.000058  copilot#Request()
    3   4.451375   0.000092  <SNR>71_AgentRequest()
    6   4.451242   4.451096  <SNR>71_Send()
    3   0.008823   0.001926  copilot#doc#Params()
    5   0.007114   0.000107  <SNR>35_Event()
    3   0.006897   0.006475  copilot#doc#Get()
    5   0.005713   0.000291  copilot#Clear()
    4   0.005379   0.000175  copilot#Schedule()
    5   0.005045   0.000761  <SNR>36_UpdatePreview()
    5   0.003847             <SNR>36_ClearPreview()
   17   0.003622   0.003201  <SNR>61_Highlight_Matching_Pair()
    3   0.003612   0.000022  copilot#OnCursorMovedI()
    1   0.002370   0.000531  copilot#OnInsertEnter()
    1   0.001025   0.000005  copilot#OnInsertLeave()
    3   0.000961   0.000036  <lambda>15()
    3   0.000925             <SNR>71_OnOut()
    4   0.000511   0.000120  copilot#Enabled()

FUNCTIONS SORTED ON SELF TIME
count  total (s)   self (s)  function
    6   4.451242   4.451096  <SNR>71_Send()
    3   0.006897   0.006475  copilot#doc#Get()
    5              0.003847  <SNR>36_ClearPreview()
   17   0.003622   0.003201  <SNR>61_Highlight_Matching_Pair()
    3   0.008823   0.001926  copilot#doc#Params()
    3              0.000925  <SNR>71_OnOut()
    5   0.005045   0.000761  <SNR>36_UpdatePreview()
    1   0.002370   0.000531  copilot#OnInsertEnter()
   17              0.000421  <SNR>61_Remove_Matches()
    5   0.000437   0.000421  <SNR>36_SuggestionTextWithAdjustments()
    3   4.460719   0.000295  copilot#Complete()
    5   0.005713   0.000291  copilot#Clear()
    3              0.000280  <SNR>94_RelativePath()
    4              0.000236  <SNR>36_BufferDisabled()
    3              0.000183  <SNR>71_SetUpRequest()
    4   0.005379   0.000175  copilot#Schedule()
    3   0.000400   0.000171  <SNR>71_OnMessage()
    3   4.460965   0.000162  <SNR>36_Trigger()
    3              0.000156  <SNR>71_OnResponse()
    9              0.000133  copilot#logger#Raw()j
```

As you can see, around 4 seconds was spent fetching Copilot suggestions in the
`copilot#Suggest()` call, which is unacceptably slow.

To remedy, I added an autocommand to disable Copilot for large files:

```vim
" (Line-wrapped for legibility)
autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>"))
    \ | if f > 100000 || f == -2
    \ | let b:copilot_enabled = v:false
    \ | endif
```

This autocommand runs when loading a new buffer. It fetches the file size and
disables Copilot for the buffer if the file size is greater than 100kb.

This autocommand was adapted from a similar one in the [Vim tips
wiki][vim_wiki].

[vim_copilot]: https://github.com/github/copilot.vim
[vim_wiki]: https://vim.fandom.com/wiki/Faster_loading_of_large_files
[profiling]:
  https://codeinthehole.com/tips/debugging-vim-by-example/#why-is-action-slow
