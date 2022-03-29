# BashFla.sh :card_index:

## Summary

BashFla.sh is a simple script for practicing flash cards in your terminal. It reads from a single CSV file and has some basic settings for replaying wrong answers and shuffling the cards.

Settings can be adjusted at the top of the shell script.

More features to come depending on how useful I find it.

## Try it out

```
cd /tmp
wget https://raw.githubusercontent.com/jnabasny/BashFla.sh/main/{bashfla.sh,danish}
bash bashfla.sh danish
```

## Example

`$ ./bashfla.sh danish`

```
Danish: Hej (high)
English: Hello

Right: 1 - Wrong: 0


Danish: God morgen (gor morn)
English: Good morning

Right: 2 - Wrong: 0


Danish: god dag (gu day)
English: good day

Right: 2 - Wrong: 1

CORRECT ANSWER: good afternoon
```
