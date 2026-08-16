// Async and await

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

async function getAnswer() {
  await sleep(5000); // Simulate heavy work
  return 42;
}

let answer = await getAnswer();
console.log(answer);
