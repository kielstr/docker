function sum_column ( column, target ) {
  column.sum("keyup", target);
}

function count_column ( column, target ) {
  column.keyup(function () {
    var count = 0;

    column.each( function () {
      if( this.value != '' && ! isNaN( this.value ) ) {
        count++;
      }
    });

    $(target).text( count );
  });
}

function min_column ( column, target ) {
  column.keyup( function () {
    var values = column.not('[value=""]').map( function(){
      return isNaN( $(this).val() )
        ? undefined
        : $(this).val();
    }).get();

    var min = ( values.length == 0 )
      ? '-'
      : values.sort(function(a,b){return a-b}).shift();

    $(target).text( min );
  });
}

function max_column ( column, target ) {
  column.keyup( function () {
    var values = column.not('[value=""]').map( function(){
      return isNaN( $(this).val() )
        ? undefined
        : $(this).val();
    }).get();

    var max = ( values.length == 0 )
      ? '-'
      : values.sort(function(a,b){return a-b}).pop();

    $(target).text( max );
  });
}

function avg_column ( column, target ) {
  column.keyup( function () {
    var count = 0,
        sum = 0;

    column.each( function () {
      if( this.value != '' && ! isNaN( this.value ) ) {
        sum = sum + Number( this.value );
        count++;
      }
    });

    var mean = ( count == 0 )
      ? '-'
      : ( sum / count ).toFixed(2);

    $(target).text( mean );
  });
}
