library(rmarkdown)
library(tidyverse)

set.seed(1233)

# short student emails
student_emails <- read_csv('class-list.csv') |>
  filter(Name != 'I. Droptout') |> # dropped
  filter(Name != 'I. Audited') |> # audited
  separate(col = `Email address`, into = c('short_email', NA), sep = '@') |>
  mosaic::shuffle() |>
  select(-orig.id)

# names of files with problems (to be "children")
problem_files <- list.files(path = 'problems',
                            pattern = '*.Rmd') |>
  mosaic::shuffle()

for(s in c(1:nrow(student_emails))){
  student_id <- student_emails |> pull(short_email) |> nth(s)
  prob_file <- paste0('problems/', problem_files[s])
  render("final-exam-master.Rmd",
         output_file = paste0("individual-tests/final-exam-", student_id, ".html"),
         # note: will need to copy to docs folder to publish
         params = list(new_title = paste("Final Exam, STAT 243 for ", student_id)))
}
