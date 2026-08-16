// Callbacks

function getAnswer(callback) {
  // Simulate heavy work
  setTimeout(() => {
    callback(42);
  }, 5000);
}

getAnswer((answer) => {
  console.log(answer);
});
