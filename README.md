# Sliding Puzzle Solver with Pattern Databases

This project forks the original work [sliding_puzzle](https://github.com/O-I/sliding_puzzle) and implements a solver using Pattern Databases.

# Requirements

* Ruby 2.1.2 (hint: use RVM)
* Bundler installed 

# Installing

```
git clone https://github.com/O-I/sliding_puzzle.git
cd sliding_puzzle
bundle install

```

# Running

`ruby ./sliding_puzzle.rb`

# Expected response

```
============ Challenge - 01 ====================

       user     system      total        real
MD  0.080000   0.000000   0.080000 (  0.079460)
PDB  0.080000   0.000000   0.080000 (  0.082267)
{:nodes_visited=>8, :nodes_enqueued=>15, :directions=>[:right], :h=>:manhattan_distance}
{:nodes_visited=>8, :nodes_enqueued=>19, :directions=>[:right], :h=>:pattern_database}

============ Challenge - 02 ====================

       user     system      total        real
MD  0.140000   0.000000   0.140000 (  0.144465)
PDB  0.200000   0.010000   0.210000 (  0.202875)
{:nodes_visited=>14, :nodes_enqueued=>28, :directions=>[:right, :right], :h=>:manhattan_distance}
{:nodes_visited=>19, :nodes_enqueued=>39, :directions=>[:right, :right], :h=>:pattern_database}

============ Challenge - 03 ====================

       user     system      total        real
MD  0.220000   0.000000   0.220000 (  0.217679)
PDB  0.390000   0.000000   0.390000 (  0.392735)
{:nodes_visited=>21, :nodes_enqueued=>38, :directions=>[:down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>35, :nodes_enqueued=>72, :directions=>[:down, :right, :right], :h=>:pattern_database}

============ Challenge - 04 ====================

       user     system      total        real
MD  0.360000   0.000000   0.360000 (  0.357964)
PDB  0.380000   0.000000   0.380000 (  0.379316)
{:nodes_visited=>33, :nodes_enqueued=>61, :directions=>[:down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>35, :nodes_enqueued=>69, :directions=>[:down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 05 ====================

       user     system      total        real
MD  0.680000   0.000000   0.680000 (  0.681151)
PDB  0.680000   0.000000   0.680000 (  0.687092)
{:nodes_visited=>60, :nodes_enqueued=>107, :directions=>[:left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>62, :nodes_enqueued=>123, :directions=>[:left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 06 ====================

       user     system      total        real
MD  2.080000   0.000000   2.080000 (  2.084571)
PDB  1.050000   0.010000   1.060000 (  1.046852)
{:nodes_visited=>184, :nodes_enqueued=>325, :directions=>[:up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>90, :nodes_enqueued=>174, :directions=>[:up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 07 ====================

       user     system      total        real
MD  3.860000   0.000000   3.860000 (  3.857340)
PDB  1.170000   0.000000   1.170000 (  1.170984)
{:nodes_visited=>332, :nodes_enqueued=>590, :directions=>[:left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>106, :nodes_enqueued=>201, :directions=>[:left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 08 ====================

       user     system      total        real
MD  6.340000   0.020000   6.360000 (  6.360204)
PDB  1.610000   0.000000   1.610000 (  1.610870)
{:nodes_visited=>518, :nodes_enqueued=>914, :directions=>[:up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>139, :nodes_enqueued=>262, :directions=>[:up, :left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 09 ====================

       user     system      total        real
MD  8.490000   0.010000   8.500000 (  8.496692)
PDB  4.100000   0.000000   4.100000 (  4.102609)
{:nodes_visited=>738, :nodes_enqueued=>1298, :directions=>[:right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>349, :nodes_enqueued=>654, :directions=>[:right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 10 ====================

       user     system      total        real
MD 14.540000   0.020000  14.560000 ( 14.565523)
PDB  5.540000   0.020000   5.560000 (  5.557971)
{:nodes_visited=>1233, :nodes_enqueued=>2140, :directions=>[:down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>483, :nodes_enqueued=>902, :directions=>[:down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 11 ====================

       user     system      total        real
MD 21.120000   0.010000  21.130000 ( 21.130144)
PDB 10.590000   0.000000  10.590000 ( 10.591970)
{:nodes_visited=>1775, :nodes_enqueued=>3072, :directions=>[:right, :down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>887, :nodes_enqueued=>1670, :directions=>[:right, :down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 12 ====================

       user     system      total        real
MD 28.150000   0.010000  28.160000 ( 28.146170)
PDB 15.950000   0.000000  15.950000 ( 15.953072)
{:nodes_visited=>2386, :nodes_enqueued=>4172, :directions=>[:down, :right, :down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>1349, :nodes_enqueued=>2529, :directions=>[:down, :right, :down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 13 ====================

       user     system      total        real
MD 46.180000   0.030000  46.210000 ( 46.202965)
PDB 24.700000   0.020000  24.720000 ( 24.718707)
{:nodes_visited=>3858, :nodes_enqueued=>6705, :directions=>[:left, :down, :right, :down, :right, :up, :left, :up, :left, :down, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>2071, :nodes_enqueued=>3867, :directions=>[:down, :down, :right, :up, :left, :left, :up, :right, :down, :left, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 14 ====================

       user     system      total        real
MD 84.630000   0.130000  84.760000 ( 84.754597)
PDB 17.380000   0.040000  17.420000 ( 17.412151)
{:nodes_visited=>6601, :nodes_enqueued=>11477, :directions=>[:left, :down, :down, :right, :up, :left, :left, :up, :right, :down, :left, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>1389, :nodes_enqueued=>2590, :directions=>[:left, :down, :left, :up, :right, :down, :down, :right, :up, :left, :left, :down, :right, :right], :h=>:pattern_database}

============ Challenge - 15 ====================

       user     system      total        real
MD133.620000   0.040000 133.660000 (133.658905)
PDB 16.550000   0.010000  16.560000 ( 16.552896)
{:nodes_visited=>10404, :nodes_enqueued=>18071, :directions=>[:up, :left, :down, :left, :up, :right, :down, :down, :right, :up, :left, :left, :down, :right, :right], :h=>:manhattan_distance}
{:nodes_visited=>1291, :nodes_enqueued=>2401, :directions=>[:up, :left, :down, :down, :right, :up, :left, :left, :up, :right, :down, :left, :down, :right, :right], :h=>:pattern_database}


```







