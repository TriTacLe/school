// Promises only

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

function getAnswer() {
  // Simulate heavy work
  return sleep(5000).then(() => {
    return 42;
  });
}

getAnswer().then((answer) => {
  console.log(answer);
});
