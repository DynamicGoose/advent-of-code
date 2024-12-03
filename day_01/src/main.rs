use std::fs::read_to_string;

fn main() {
    let input = read_to_string("input.txt").unwrap();
    let mut list_1: Vec<u32> = vec![];
    let mut list_2: Vec<u32> = vec![];

    // parsing the input
    input.lines().for_each(|line| {
        let values = line.split_whitespace().collect::<Vec<&str>>();
        list_1.push(values[0].parse().unwrap());
        list_2.push(values[1].parse().unwrap());
    });

    part_one(list_1.to_owned(), list_2.to_owned());
    part_two(list_1, list_2);
}

fn part_one(mut list_1: Vec<u32>, mut list_2: Vec<u32>) {
    list_1.sort_unstable();
    list_2.sort_unstable();

    let mut distance: u32 = 0;
    for i in 0..list_1.len() {
        let value_1 = list_1[i];
        let value_2 = list_2[i];
        distance += value_1.abs_diff(value_2);
    }

    println!("{distance}");
}

fn part_two(list_1: Vec<u32>, list_2: Vec<u32>) {
    let mut similarity: u32 = 0;

    for n in list_1 {
        similarity += n * list_2.iter().filter(|m| **m == n).count() as u32;
    }

    println!("{similarity}")
}
