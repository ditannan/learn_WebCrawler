## -*-coding: utf-8 -*-
## 

library("rvest")

url <- "https://www.liepin.com/zhaopin/?industries=&dqs=&salary=&jobKind
=&pubTime=&compkind=&compscale=&industryType=&searchType=1&clean_condition=
&isAnalysis=&init=1&sortFlag=15&flushckid=0&fromSearchBtn=
1&headckid=1c3901a0798fb517&d_headId=f1bd455a7dd09e0a402a50cc8965de33&d_ckId=
f1bd455a7dd09e0a402a50cc8965de33&d_sfrom=search_unknown&d_curPage=0&d_pageSize=
40&siTag=1B2M2Y8AsgTpgAmY7PhCfg~fA9rXquZc5IkJpXC-Ycixw&key=
%E6%95%B0%E6%8D%AE%E5%88%86%E6%9E%90%E5%B8%88"

page <- read_html(url)
# 提取职位
position <- page %>% 
  html_nodes('ul.sojob_list .sojob-item-main .job-info, h3 a') %>% 
  html_text(trim = TRUE)
position <- position[-41]
# 提取链接
link <- page %>% 
  html_nodes('ul.sojob_list div.job-info, h3 a') %>% 
  html_attrs()
#link.url <- c(1 : length(link))
#for (i in seq_along(link)) {
#  link.url[i] <- link[[i]][1]
#}
link.url <- sapply(link, `[`, 'href')
link.url <- unname(link.url[-41])
# 提取薪资
salary <- page %>% 
  html_nodes('span.text-warning') %>% 
  html_text()
# 提取工作地点
workplace <- page %>% 
  html_nodes('p.condition a') %>% 
  html_text()
workplace
# 教育背景
edu <- page %>% 
  html_nodes('span.edu') %>% 
  html_text()
edu
# 工资教育背景经验
condition <- page %>% 
  html_nodes('p.condition span') %>% 
  html_text()
exp <- condition[unlist(lapply(seq(120), function(x) x%%3 == 0))]
exp
# 合并到一个dataframe
webdf <- data.frame(
  position = position,
  salary = salary,
  education = edu,
  experience = exp,
  workplace = workplace,
  link = link.url
)
View(webdf)