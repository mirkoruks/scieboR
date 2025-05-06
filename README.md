
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scieboR

<!-- badges: start -->
<!-- badges: end -->

The goal of scieboR is to interact with the German university cloud
[Sciebo](https://hochschulcloud.nrw/). With interact I mean: 1) Upload
files using `sciebo_upload()`, 2) download files using
`sciebo_download()` and 3) deleting files using `sciebo_delete()`. Note,
this package is not officially endorsed.

## Installation

You can install the development version of scieboR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mirkoruks/scieboR")
```

## Example Upload

This is a basic example which shows you how to upload a file using
`sciebo_upload()`:

    library(scieboR)
    sciebo_upload(uni = "uni-bielefeld", # string referring to your affiliation
                  user = "your_username", # your sciebo user name 
                  pw = "your_pw", # your sciebo password
                  overwrite = FALSE, # default: do not overwrite existing files with the same name
                  sciebo_file = "directory/file.txt", # sciebo destination
                  local_file = "directory/file.txt" # local file to be uploaded
                  )

## Example Download

This is a basic example which shows you how to download a file using
`sciebo_download()`:

    library(scieboR)
    sciebo_download(uni = "uni-bielefeld", # string referring to your affiliation
                    user = "your_username", # your sciebo user name 
                    pw = "your_pw", # your sciebo password
                    overwrite = FALSE, # default: do not overwrite existing files with the same name
                    sciebo_file = "directory/file.txt", # file in sciebo to be downloaded
                    local_file = "directory/file.txt" # local destination 
                    )

## Example Delete

This is a basic example which shows you how to delete a file using
`sciebo_delete()`:

    library(scieboR)
    sciebo_delete(uni = "uni-bielefeld", # string referring to your affiliation
                  user = "your_username", # your sciebo user name 
                  pw = "your_pw", # your sciebo password
                  sciebo_file = "directory/file.txt", # string with file in sciebo to be deleted
                  )
                  
