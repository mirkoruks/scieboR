#' Title
#'
#' @param uni a string with your university affiliation (e.g., "uni-bielefeld" for Bielefeld University)
#' @param user a string with your sciebo user name
#' @param pw a string with your sciebo password
#' @param sciebo_file a string with the directory and name of the file to be deleted from sciebo ("directory/file.txt")
#'
#' @returns
#' @export
#'
#' @examples sciebo_upload(uni = "uni-bielefeld", user = "myusername", pw = "mypw", sciebo_file = "test/sciebofile.txt")
#' @import httr2
#' @export
sciebo_delete <- function(uni = "uni-bielefeld", user, pw, sciebo_file = NULL) {
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
        req_method("DELETE") |>
        req_perform()

    if (resp_status(resp) == 204) {
        cat("File deleted successfully.\n")
    } else {
        cat("Deletion failed. Status:", resp_status(resp), "\n")
    }
}
