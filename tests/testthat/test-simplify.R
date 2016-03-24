context("lawn_simplify")

feature <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-70.603637, -33.399918],
      [-70.614624, -33.395332],
      [-70.639343, -33.392466],
      [-70.659942, -33.394759],
      [-70.683975, -33.404504],
      [-70.697021, -33.419406],
      [-70.701141, -33.434306],
      [-70.700454, -33.446339],
      [-70.694274, -33.458369],
      [-70.682601, -33.465816],
      [-70.668869, -33.472117],
      [-70.646209, -33.473835],
      [-70.624923, -33.472117],
      [-70.609817, -33.468107],
      [-70.595397, -33.458369],
      [-70.587158, -33.442901],
      [-70.587158, -33.426283],
      [-70.590591, -33.414248],
      [-70.594711, -33.406224],
      [-70.603637, -33.399918]
    ]]
  }
}'

feature2 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [
      [
        [52.8658, -44.7219],
        [53.7702, -40.4873],
        [54.5983, -38.9206],
        [54.3694, -40.2055],
        [55.3204, -37.5579],
        [56.2757, -37.917],
        [55.8025, -39.974],
        [56.184, -40.6443],
        [56.0527, -41.428],
        [55.8639, -41.8601],
        [55.2698, -43.3478],
        [53.2038, -45.3591],
        [58.7924, -40.5458],
        [59.3436, -40.8043],
        [61.0835, -40.7529],
        [55.8822, -44.2364],
        [56.252, -44.1525],
        [58.0202, -43.634],
        [58.6638, -44.2017],
        [53.0884, -45.7021],
        [61.6699, -45.0678],
        [62.737, -46.2841],
        [55.7763, -46.2637],
        [61.5985, -48.0536],
        [55.4919, -46.7674],
        [55.3808, -46.885],
        [61.3726, -50.3026],
        [54.3448, -46.7941],
        [56.1968, -48.2469],
        [58.3038, -50.4299],
        [58.1317, -51.1977],
        [55.4059, -48.478],
        [53.9739, -47.2032],
        [56.8275, -50.6531],
        [54.9742, -49.1184],
        [54.3321, -48.2222],
        [53.2685, -46.5573],
        [53.5411, -47.2954],
        [53.0315, -46.4398],
        [54.0485, -50.8807],
        [52.799, -45.9386],
        [54.385, -55.3905],
        [53.3764, -54.4511],
        [53.1668, -51.5554],
        [52.7066, -46.8397],
        [51.5802, -52.7235],
        [52.0329, -49.5677],
        [50.0123, -54.9834],
        [50.1747, -52.1814],
        [49.0098, -52.3641],
        [52.6261, -45.9815],
        [50.6588, -48.7081],
        [50.5593, -48.1831],
        [47.7777, -50.7152],
        [52.5873, -45.8944],
        [52.6129, -45.8691],
        [49.175, -48.3844],
        [45.4671, -49.9292],
        [49.5584, -47.4359],
        [43.9643, -49.163],
        [52.7068, -45.7639],
        [43.2278, -47.1908],
        [45.1936, -46.5388],
        [50.1948, -46.0062],
        [46.7929, -45.9982],
        [44.2366, -45.5022],
        [51.6188, -45.6201],
        [48.4755, -45.1388],
        [49.6271, -45.2296],
        [47.1939, -44.7799],
        [43.7748, -43.6074],
        [48.9974, -44.2912],
        [48.3348, -43.8854],
        [52.0881, -45.385],
        [50.2184, -44.2319],
        [48.2389, -42.4925],
        [50.622, -44.0168],
        [50.327, -43.5207],
        [48.0804, -41.2784],
        [46.7767, -38.3542],
        [48.347, -40.2708],
        [49.0358, -40.5943],
        [48.9158, -39.8798],
        [49.6307, -40.6159],
        [51.1783, -42.3294],
        [52.4858, -45.0418],
        [50.7531, -40.0718],
        [52.44, -44.6258],
        [51.9617, -40.4054],
        [52.4043, -42.1861],
        [52.8658, -44.7219]
      ]
    ]
  }
}'

linestring1 <- '[
   [-21.964416, 64.148203],
   [-21.956176, 64.141316],
   [-21.93901, 64.135924],
   [-21.927337, 64.136673]
]'

a <- lawn_simplify(feature)
b <- lawn_simplify(lawn_linestring(linestring1))

test_that("lawn_hex_grid returns correct classes", {
  expect_is(a, "polygon")
  expect_is(a$type, "character")
  expect_equal(a$type, "Feature")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")

  expect_is(b, "linestring")
  expect_is(b$type, "character")
  expect_equal(b$type, "Feature")
  expect_is(b$geometry$type, "character")
  expect_is(b$geometry$coordinates, "matrix")
})

test_that("tolerance parameter works as expected", {
  expect_lt(length(lawn_simplify(feature, 0.01)$geometry$coordinates[,,1]),
                   length(lawn_simplify(feature, 0.001)$geometry$coordinates[,,1]))
  expect_lt(length(lawn_simplify(feature, 0.02)$geometry$coordinates[,,1]),
                   length(lawn_simplify(feature, 0.01)$geometry$coordinates[,,1]))
})

test_that("high_quality parameter works as expected", {
  # in this case settingn to FALSE does result in fewer vertices,
  # but not with many values of tolerance
  expect_lt(length(lawn_simplify(feature2, 6)$geometry$coordinates[,,1]),
                   length(lawn_simplify(feature2, 6, TRUE)$geometry$coordinates[,,1]))
})

test_that("lawn_simplify fails correctly", {
  # missing arguments
  expect_error(lawn_simplify(), "argument \"feature\" is missing, with no default")
  # wrong input object
  expect_error(lawn_simplify("{}"), "Cannot read property")
  # can't pass in a character string to tolerance
  expect_error(lawn_simplify(feature, "a"), "a is not defined")
  # can't pass in a non-logical to high_quality
  expect_error(lawn_simplify(feature, high_quality = 5), "is not TRUE")
})
