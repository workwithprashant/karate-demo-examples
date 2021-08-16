function fn() {
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);
  return karate.call('classpath:examples/generic_functions.feature');
}