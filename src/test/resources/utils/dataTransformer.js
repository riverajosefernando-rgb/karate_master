function fn(data){

  var result = [];

  for(var i = 0; i < data.length; i++){

      var item = data[i];

      item.timestamp = new Date().getTime();

      result.push(item);
  }

  return result;
}