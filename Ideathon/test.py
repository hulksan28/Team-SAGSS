from better_profanity import profanity 
  
# text to be censored 
text = "What the shit and fuck you are you doing?"
  
# do censoring 
censored = profanity.censor(text) 
  
# view output 
print(censored)