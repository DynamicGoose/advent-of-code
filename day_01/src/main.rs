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
