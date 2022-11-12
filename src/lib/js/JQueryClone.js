class AjaxPromise {
  constructor(promise){
    this.promise = promise;
  }
  
  done(cb){
    this.promise = this.promise.then(data=>{
      cb(data);
      return data;
    })
    return this;
  }
  
  fail(cb){
    this.promise = this.promise.catch(cb);
    return this;
  }
  
  always(cb){
    this.promise = this.promise.finally(cb);
    return this;
  }
}

class ElementCollection extends Array {
  
  ready(cb){
    const isReady = this.some(e =>{
      return e.readState != null && e.readyState != 'loading';
    });
    if (isReady){
      cb();
    } else {
      this.on('DOMContentLoaded', cb);
    }
    return this;
  }
  
  // children(param = '*'){
  //   let list = [];
  //   this.forEach(element =>{
  //     element.querySelectorAll(param).forEach(child => {
  //       list.push(child);
  //     })
  //   })
  //   return new ElementCollection(...list);
  // }
  
  on(event, cbOrSelector, cb){
    if (typeof cbOrSelector === "function"){
        this.forEach(element => element.addEventListener(event, cbOrSelector));
    } else {
      // this.forEach(element=>{
      //   element.addEventListener(event, e=>{
      //     if (e.target.matches(cbOrSelector)) {cb(e)}
      //   })
      // })
    }
    
    return this;
  }

  toggleClass(className){
    this.forEach(element=>{element.classList.toggle(className)});
    return this;
  }

  addClass(className){
    this.forEach(element=>{element.classList.add(className)});
    return this;
  }

  removeClass(className){
    this.forEach(element=>{element.classList.remove(className)});
    return this;
  }
  
  css(property, value){
    const camelProp = property.replace(/(-[a-z])/, g =>{ return g.replace('-','').toUpperCase()});
    this.forEach(e => e.style[camelProp] = value);
    return this;
  }
  
  next(){
    return this.map(e=>e.nextElementSibling).filter(e=>e!=null);
  }
  
  prev(){
    return this.map(e=>e.previousElementSibling).filter(e=>e!=null);
  }

}

function $(param){
  if (typeof param === 'string' || param instanceof String){
    return new ElementCollection(...document.querySelectorAll(param))
  } else {
    return new ElementCollection(param);
  }
  
}

function getCookie(name){
  let cookieValue = null;
  if (document.cookie && document.cookie !== ''){
    const cookies = document.cookie.split(";");
    cookies.forEach(cookie =>{
      if (cookie.substring(0, name.length+1) === (name +"=")){
        cookieValue = decodeURIComponent(cookie.substring(name.length+1));
      }
    })
  }
  return cookieValue;
}

$.get = function(url, data={}, success = () => {}, dataType){
  const queryString = Object.entries(data).map(([key,value])=>{
    return `${key}=${value}`;
  }).join('&');
  return new AjaxPromise(fetch(`${url}?${queryString}`,{
    method: "GET",
    headers: {
      "Content-Type": dataType,
    },
  }).then(res => {
    if (res.ok){return res.json()}
    else {throw new Error(res.status)}
  }).then(data => success(data)));
  
}

$.post = function(url, data={}, success = () => {}, dataType = JSON){
  const queryString = Object.entries(data).map(([key,value])=>{
    return `${key}=${value}`;
  }).join('&');
  return new AjaxPromise(fetch(`${url}`,{
    method: "POST",
    mode: 'same-origin',
    credentials: 'same-origin',
    headers: {
      "Accept" : "application/json",
      "Content-Type": dataType,
      "X-Requested-Width" : "XMLHttpRequest",
      // "X-CSRFToken" : data.csrftoken,
      "X-CSRFToken" : getCookie('csrftoken'),
    },
    body: JSON.stringify(data),
  }).then(res => {
    if (res.ok){return res.json()}
    else {throw new Error(res.status)}
  }).then(data => success(data)));
  
}

$.put = function(url, data={}, success = () => {}, dataType = JSON){
  const queryString = Object.entries(data).map(([key,value])=>{
    return `${key}=${value}`;
  }).join('&');
  return new AjaxPromise(fetch(`${url}`,{
    method: "PUT",
    mode: 'same-origin',
    credentials: 'same-origin',
    headers: {
      "Accept" : "application/json",
      "Content-Type": dataType,
      "X-Requested-Width" : "XMLHttpRequest",
      "X-CSRFToken" : data.csrftoken,
    },
    body: JSON.stringify(data),
  }).then(res => {
    if (res.ok){return res.json()}
    else {throw new Error(res.status)}
  }).then(data => success(data)));
  
}