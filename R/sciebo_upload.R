#' Upload file to Sciebo
#' @param uni a string with your university affiliation (e.g., "uni-bielefeld" for Bielefeld University)
#' @param user a string with your sciebo user name
#' @param pw a string with your sciebo password
#' @param overwrite a logical indicating whether you want to overwrite existing files with the same name
#' @param sciebo_file a string with the directory and name of the file to be saved in sciebo ("directory/file.txt")
#' @param local_file a string with the directory and name of your local file ("directory/file.txt")
#' @import httr2
#' @export
sciebo_upload <- function(uni = "uni-bielefeld", user, pw, overwrite = FALSE, sciebo_file, local_file) {
    if (is.null(sciebo_file)) {
        stop("Please provide the name for the file to be saved in sciebo.")
    }
    if (is.null(local_file)) {
        stop("Please provide the name of the local file to be uploaded.")
    }

    url <- paste0("https://", uni, ".sciebo.de/remote.php/webdav/", sciebo_file)

    check_resp <- request(url) |>
        req_auth_basic(user, pw) |>
        req_method("HEAD") |>
        req_error(is_error = \(x) FALSE) |>
        req_perform()

    if (overwrite == FALSE) {
        if (resp_status(check_resp) == 200) {
            stop(paste0("File ",sciebo_file," already exists in sciebo. If you want to overwrite, set overwrite = TRUE\n"))
        }
    }

    req <- request(url) |>
        req_auth_basic(user, pw) |>
        req_method("PUT") |>
        req_body_file(local_file)

    resp <- req_perform(req)

    if (resp_status(resp) == 201) {
        cat("File uploaded successfully.\n")
    } else {
        cat("Upload failed. Status:", resp_status(resp), "\n")
    }
}

