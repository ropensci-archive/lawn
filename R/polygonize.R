#' Polygonizes multi-linestring's to polygons
#'
#' Takes a [data-LineString] or [data-MultiLineString] and returns
#' [data-Polygon]'s
#'
#' Polygonizes a set of lines that represents edges in a planar graph. Edges
#' must be correctly noded, i.e., they must only meet at their endpoints.
#'
#' @keywords internal
#' @param lines Line(s) to polygonze
#' @template lint
#' @return one or more [data-Polygon]
#' @examples \dontrun{
#'  # line <- '{
#'  #   "type": "FeatureCollection",
#'  #   "features": [
#'  #     {
#'  #      "type": "Feature",
#'  #      "properties": {
#'  #        "stroke": "#F00"
#'  #     },
#'  #      "geometry": {
#'  #        "type": "LineString",
#'  #        "coordinates": [[-83, 30], [-84, 36], [-78, 41]]
#'  #      }
#'  #    },
#'  #     {
#'  #      "type": "Feature",
#'  #      "properties": {
#'  #        "stroke": "#F00"
#'  #     },
#'  #      "geometry": {
#'  #        "type": "LineString",
#'  #        "coordinates": [[-86, 34], [-88, 33], [-73, 39]]
#'  #      }
#'  #    }
#'  #  ]
#'  # }'
#'  #
#'  # line <- '{
#'  #   "type": "FeatureCollection",
#'  #   "features": [
#'  #     {
#'  #      "type": "Feature",
#'  #      "geometry": {
#'  #        "type": "LineString",
#'  #        "coordinates": [[0, 0], [1, 1]]
#'  #      }
#'  #    },
#'  #     {
#'  #      "type": "Feature",
#'  #      "geometry": {
#'  #        "type": "LineString",
#'  #        "coordinates": [[1, 1], [-1, -1]]
#'  #      }
#'  #    },
#'  #     {
#'  #      "type": "Feature",
#'  #      "geometry": {
#'  #        "type": "LineString",
#'  #        "coordinates": [[-1, -1], [0, 0]]
#'  #      }
#'  #    }
#'  #  ]
#'  # }'
#'
#'
#'  # x <- '{
#'  #   "type": "FeatureCollection",
#'  #   "features": [
#'  #     {
#'  #       "type": "Feature",
#'  #       "properties": {},
#'  #       "geometry": {
#'  #         "type": "LineString",
#'  #         "coordinates": [
#'  #           [
#'  #             119.00390625,
#'  #             -22.024545601240337
#'  #           ],
#'  #           [
#'  #             120.58593749999999,
#'  #             -28.613459424004414
#'  #           ],
#'  #           [
#'  #             125.595703125,
#'  #             -32.99023555965107
#'  #           ],
#'  #           [
#'  #             133.330078125,
#'  #             -32.99023555965107
#'  #           ],
#'  #           [
#'  #             142.646484375,
#'  #             -30.977609093348676
#'  #           ],
#'  #           [
#'  #             142.294921875,
#'  #             -24.126701958681668
#'  #           ],
#'  #           [
#'  #             139.04296875,
#'  #             -16.299051014581817
#'  #           ],
#'  #           [
#'  #             128.84765625,
#'  #             -15.199386048559994
#'  #           ]
#'  #         ]
#'  #       }
#'  #     },
#'  #     {
#'  #       "type": "Feature",
#'  #       "properties": {},
#'  #       "geometry": {
#'  #         "type": "LineString",
#'  #         "coordinates": [
#'  #           [
#'  #             142.646484375,
#'  #             -30.977609093348676
#'  #           ],
#'  #           [
#'  #             132.451171875,
#'  #             -27.449790329784214
#'  #           ],
#'  #           [
#'  #             128.671875,
#'  #             -23.1605633090483
#'  #           ],
#'  #           [
#'  #             119.00390625,
#'  #             -22.024545601240337
#'  #           ]
#'  #         ]
#'  #       }
#'  #     }
#'  #   ]
#'  # }'
#'  # lawn_polygonize(lines = x)
#' }
lawn_polygonize <- function(lines, lint = FALSE) {
  stop("not working yet", call. = FALSE)
  # lines <- convert(lines)
  # lawnlint(lines, lint)
  # ct$eval(sprintf("var polygs = turf.polygonize(%s);", lines))
  # #as.f(
  #   ct$get("polygs")
  # #)
}
