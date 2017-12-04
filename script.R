
# Noetige Bibliotheken laden
library(rvest)
library(data.table)
#library(stargazer)


# https://regex101.com
# https\:\/\/helpcenter.garaio-rem\.ch\?page\_id\=[0-9]*

sites <- c(
    'https://helpcenter.garaio-rem.ch?page_id=1652',
    'https://helpcenter.garaio-rem.ch?page_id=207',
    'https://helpcenter.garaio-rem.ch?page_id=2',
    'https://helpcenter.garaio-rem.ch?page_id=18',
    'https://helpcenter.garaio-rem.ch?page_id=14',
    'https://helpcenter.garaio-rem.ch?page_id=16',
    'https://helpcenter.garaio-rem.ch?page_id=2',
    'https://helpcenter.garaio-rem.ch?page_id=18',
    'https://helpcenter.garaio-rem.ch?page_id=207',
    'https://helpcenter.garaio-rem.ch?page_id=209',
    'https://helpcenter.garaio-rem.ch?page_id=214',
    'https://helpcenter.garaio-rem.ch?page_id=156',
    'https://helpcenter.garaio-rem.ch?page_id=277',
    'https://helpcenter.garaio-rem.ch?page_id=281',
    'https://helpcenter.garaio-rem.ch?page_id=358',
    'https://helpcenter.garaio-rem.ch?page_id=283',
    'https://helpcenter.garaio-rem.ch?page_id=360',
    'https://helpcenter.garaio-rem.ch?page_id=285',
    'https://helpcenter.garaio-rem.ch?page_id=287',
    'https://helpcenter.garaio-rem.ch?page_id=289',
    'https://helpcenter.garaio-rem.ch?page_id=291',
    'https://helpcenter.garaio-rem.ch?page_id=293',
    'https://helpcenter.garaio-rem.ch?page_id=295',
    'https://helpcenter.garaio-rem.ch?page_id=297',
    'https://helpcenter.garaio-rem.ch?page_id=299',
    'https://helpcenter.garaio-rem.ch?page_id=14',
    'https://helpcenter.garaio-rem.ch?page_id=696',
    'https://helpcenter.garaio-rem.ch?page_id=334',
    'https://helpcenter.garaio-rem.ch?page_id=235',
    'https://helpcenter.garaio-rem.ch?page_id=237',
    'https://helpcenter.garaio-rem.ch?page_id=239',
    'https://helpcenter.garaio-rem.ch?page_id=273',
    'https://helpcenter.garaio-rem.ch?page_id=225',
    'https://helpcenter.garaio-rem.ch?page_id=227',
    'https://helpcenter.garaio-rem.ch?page_id=229',
    'https://helpcenter.garaio-rem.ch?page_id=233',
    'https://helpcenter.garaio-rem.ch?page_id=241',
    'https://helpcenter.garaio-rem.ch?page_id=243',
    'https://helpcenter.garaio-rem.ch?page_id=245',
    'https://helpcenter.garaio-rem.ch?page_id=247',
    'https://helpcenter.garaio-rem.ch?page_id=249',
    'https://helpcenter.garaio-rem.ch?page_id=251',
    'https://helpcenter.garaio-rem.ch?page_id=253',
    'https://helpcenter.garaio-rem.ch?page_id=255',
    'https://helpcenter.garaio-rem.ch?page_id=257',
    'https://helpcenter.garaio-rem.ch?page_id=259',
    'https://helpcenter.garaio-rem.ch?page_id=261',
    'https://helpcenter.garaio-rem.ch?page_id=263',
    'https://helpcenter.garaio-rem.ch?page_id=265',
    'https://helpcenter.garaio-rem.ch?page_id=365',
    'https://helpcenter.garaio-rem.ch?page_id=267',
    'https://helpcenter.garaio-rem.ch?page_id=231',
    'https://helpcenter.garaio-rem.ch?page_id=269',
    'https://helpcenter.garaio-rem.ch?page_id=16',
    'https://helpcenter.garaio-rem.ch?page_id=301',
    'https://helpcenter.garaio-rem.ch?page_id=303',
    'https://helpcenter.garaio-rem.ch?page_id=305',
    'https://helpcenter.garaio-rem.ch?page_id=307',
    'https://helpcenter.garaio-rem.ch?page_id=309',
    'https://helpcenter.garaio-rem.ch?page_id=311',
    'https://helpcenter.garaio-rem.ch?page_id=313',
    'https://helpcenter.garaio-rem.ch?page_id=315',
    'https://helpcenter.garaio-rem.ch?page_id=317',
    'https://helpcenter.garaio-rem.ch?page_id=319',
    'https://helpcenter.garaio-rem.ch?page_id=321',
    'https://helpcenter.garaio-rem.ch?page_id=323',
    'https://helpcenter.garaio-rem.ch?page_id=325',
    'https://helpcenter.garaio-rem.ch?page_id=327',
    'https://helpcenter.garaio-rem.ch?page_id=329',
    'https://helpcenter.garaio-rem.ch?page_id=331',
    'https://helpcenter.garaio-rem.ch?page_id=23')


allQuestionAndAnswers <- data.table("Frage"=ls(), "Antworten"=ls())

allAnswers <- c()
allQuestions <- c()
allTopics <- c()

for(i in 1:length(sites)){
  
  answers <- c()
  questions <- c()
  
  # Url definieren
  url <- sites[i]
  
  url %>% 
    read_html() %>% 
    html_nodes(xpath = 
                 "/html/body/div/div/div[3]/div/section/div/div/div/article/div[*]/div[*]/a") %>% 
    html_text() -> questions
  
  url %>% 
    read_html() %>% 
    html_nodes(xpath = 
                 "/html/body/div/div/div[3]/div/section/div/div/div/article/div[1]/div[*]/div/div/p[1]") %>% 
    html_text() -> answers
  
  if (length(answers) > 0)
  {
    print(paste("adding rows", length(answers), " index ", i))
    allAnswers <- c(allAnswers, answers)
    allQuestions <- c(allQuestions, questions)
  }
}

questionsAndAnswers <- data.table("Frage"=allQuestions, "Antworten"=allAnswers)









