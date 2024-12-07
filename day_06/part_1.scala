import annotation.tailrec
import io.Source.fromFile

@main
def part_1(): Unit =
  val input = fromFile("../inputs/06.txt").mkString

  // parse input
  val map = input.split('\n').map(_.map(_ == '#').toVector).toVector
  val guard = input.filter("^>v<".contains).head
  val Array(guard_pos) =
    for
      (i, j) <- input.split('\n').zipWithIndex
      (k, l) <- i.zipWithIndex if (k == guard)
    yield (j, l)
  val guard_dir = guard match
    case '^' => 0
    case '>' => 1
    case 'v' => 2
    case '<' => 3
  val (x_max, y_max) = (map.size - 1, map.head.size - 1)

  // get number of visited positions
  val result = walk(
    Map(
      map,
      Set(guard_pos),
      guard_pos,
      guard_dir,
      x_max,
      y_max
    )
  ).visited.size

  println(result)

case class Map(
    map: Vector[Vector[Boolean]],
    visited: Set[(Int, Int)],
    guard_pos: (Int, Int),
    guard_dir: Int,
    x_max: Int,
    y_max: Int
)

def move(map: Map): Map =
  val next_pos = map.guard_dir match
    case 0 => (map.guard_pos._1 - 1, map.guard_pos._2)
    case 1 => (map.guard_pos._1, map.guard_pos._2 + 1)
    case 2 => (map.guard_pos._1 + 1, map.guard_pos._2)
    case 3 => (map.guard_pos._1, map.guard_pos._2 - 1)

  if (
    next_pos._1 >= 0 &&
    next_pos._1 <= map.x_max &&
    next_pos._2 >= 0 &&
    next_pos._2 <= map.y_max &&
    map.map(next_pos._1)(next_pos._2)
  ) {
    map.copy(guard_dir = map.guard_dir match
      case 0 => 1
      case 1 => 2
      case 2 => 3
      case 3 => 0
    )
  } else {
    map.copy(guard_pos = next_pos, visited = map.visited + map.guard_pos)
  }

@tailrec
def walk(map: Map): Map =
  if (
    map.guard_pos._1 < 0 || map.guard_pos._1 > map.x_max || map.guard_pos._2 < 0 || map.guard_pos._2 > map.y_max
  ) {
    return map
  } else {
    walk(move(map))
  }
