##' Retrive a list of all PEcAn runs from the database that belong to a 
##' specific workflow
##' @name get.runs
##' @title Get list of PEcAn Runs that belong to a specific workflow
##' @param server Server object obtained using the connect() function 
##' @param workflow_id ID of the PEcAn workflow for which all runs are to be retrieved
##' @param offset The number of workflows to skip before starting to collect the result set.
##' @param limit The number of workflows to return (Available values : 10, 20, 50, 100, 500)
##' @return Response obtained from the `/api/runs/` endpoint with relevant query parameters
##' @author Tezan Sahu
##' @export
##' @examples
##' server <- connect(url="http://pecan.localhost:80", username="carya", password="illinois")
##' 
##' # Get details of all runs for the workflow with ID '1000009172'
##' res <- get.runs(server, workflow_id=1000009172)

get.runs <- function(server, workflow_id, offset=0, limit=50){
  if(! is.element(limit, c(10, 20, 50, 100, 500))) {
    stop("limit can be only one of 10, 20, 50, 100 or 500")
  }
  
  res <- NULL
  tryCatch(
    expr = {
      url <- paste0(server$url, "/api/runs/?workflow_id=", workflow_id, "&offset=", offset, "&limit=", limit)
      
      if(! is.null(server$username) && ! is.null(server$password)){
        res <- httr::GET(
          url,
          httr::authenticate(server$username, server$password)
        )
      }
      else{
        res <- httr::GET(url)
      }
    },
    error = function(e) {
      message("Sorry! Server not responding")
    }
  )
  
  if(! is.null(res)) {
    if(res$status_code == 200){
      return(jsonlite::fromJSON(rawToChar(res$content)))
    }
    else if(res$status_code == 401){
      stop("Invalid credentials")
    }
    else if(res$status_code == 404){
      stop("No runs found")
    }
    else if(res$status_code == 500){
      stop("Internal server error")
    }
    else{
      stop("Unidentified error")
    }
  }
}
