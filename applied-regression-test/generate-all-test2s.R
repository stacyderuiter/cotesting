library(rmarkdown)
library(tidyverse)

set.seed(21)
## NOTE DOES NOT KEEP THE SAME RANDOMIZATION (MATCH STUDENT-PROBLEM)
## IF RERUN

# short student emails
student_emails <- read_csv('student-list.csv') |>
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
  render("test-2-master.Rmd",
         output_file = paste0("individual-tests/test2-", student_id, ".html"),
         # note: will need to copy to docs folder to publish
         params = list(new_title = paste("Test 2, STAT 245 for ", student_id)))
}
