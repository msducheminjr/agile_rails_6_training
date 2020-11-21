import React            from 'react'
import ReactDOM         from 'react-dom'
import PayTypeSelector  from 'PayTypeSelector'

document.addEventListener('turbolinks:load', function() {
  var element = document.getElementById('pay-type-component');
  if(element) {
    let orderData = JSON.parse(element.getAttribute('data'));
    ReactDOM.render(<PayTypeSelector orderData={orderData} />, element);
  }
});