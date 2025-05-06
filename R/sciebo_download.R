#' Downloads file from Sciebo
#' @param uni a string with your university affiliation (e.g., "uni-bielefeld" for Bielefeld University)
#' @param user a string with your sciebo user name
#' @param pw a string with your sciebo password
#' @param overwrite a logical indicating whether you want to overwrite existing files with the same name
#' @param sciebo_file a string with the directory and name of the file to be downloaded from sciebo ("directory/file.txt")
#' @param local_file a string with the directory and name of your local file ("directory/file.txt")
#' @import httr2
#' @export
sciebo_download <- function(uni = "uni-bielefeld", user, pw, overwrite = FALSE, sciebo_file = NULL, local_file = NULL) {
    if (is.null(sciebo_file)) {
        stop("Please provide the name for the file to be downloaded.")
    }
    if (is.null(local_file)) {
        stop("Please provide the name for the local file.")
    }

    url <- paste0("https://", uni, ".sciebo.de/remote.php/webdav/", sciebo_file)

    check_req <- request(url) |>
        req_auth_basic(user, pw) |>
        req_method("HEAD")

    check_resp <- req_perform(check_req)

    if (resp_status(check_resp) != 200) {
        stop(paste0("File ",sciebo_file," does not exist in sciebo.\n"))
    }

    resp <- request(url) |>
        req_auth_basic(user, pw) |>
        req_method("GET") |>
        req_perform()

    if (resp_status(resp) == 200) {
        if (overwrite == FALSE) {
            file_check <- file.exists(local_file)
            if (file_check == TRUE) {
                stop(paste0("File ",local_file," already exists. Set overwrite = TRUE to overwrite.\n"))
            }
        }
        writeBin(resp_body_raw(resp), local_file)
        cat("File downloaded successfully.\n")
    } else {
        cat("Download failed. Status:", resp_status(resp), "\n")
    }
}
