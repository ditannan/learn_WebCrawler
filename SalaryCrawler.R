library("rvest")
url <- "https://www.liepin.com/zhaopin/?init=1"
page <- read_html(url)
# 提取职位
position <- page %>% 
  html_nodes('ul.sojob_list div.sojob-item-main div.job-info, h3 a') %>% 
  html_text(trim = TRUE)
position <- position[-41]
# 提取链接
link <- page %>% 
  html_nodes('ul.sojob_list div.job-info, h3 a') %>% 
  html_attrs()
link.url <- c(1 : length(link))
for (i in seq_along(link)) {
  link.url[i] <- link[[i]][1]
}
link.url <- link.url[-41]
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
  experience = experience,
  workplace = workplace,
  link = link.url
)
View(webdf)