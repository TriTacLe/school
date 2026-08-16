function fibonacci1(length) {
  let prevprev = 0;
  let prev = 1;
  let result = [];
  if (length > 0) result.push(prevprev);
  if (length > 1) result.push(prev);
  for (let i = 2; i < length; i++) {
    let current = prevprev + prev;
    result.push(current);
    prevprev = prev;
    prev = current;
  }
  return result;
}

function* fibonacci2() {
  let prevprev = 0;
  let prev = 1;
  yield prevprev;
  yield prev;
  while (true) {
    let current = prevprev + prev;
    yield current;
    prevprev = prev;
    prev = current;
  }
}

for (let num of fibonacci1(13)) {
  console.log(num);
}

for (let num of fibonacci2()) {
  console.log(num);
  if (num > 100) break;
}

// The previous for loop is similar to:
let generator = fibonacci2();
for (let result = generator.next(); !result.done; result = generator.next()) {
  console.log(result.value);
  if (result.value > 100) break;
}
