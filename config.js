(function(){
  var K='cuidarKey';
  function get(){try{return localStorage.getItem(K)||''}catch(e){return ''}}
  function gate(){
    if(get()||document.getElementById('ck-gate'))return;
    if(!document.body){document.addEventListener('DOMContentLoaded',gate);return}
    var d=document.createElement('div');
    d.id='ck-gate';
    d.style.cssText='position:fixed;inset:0;z-index:2147483647;background:rgba(10,20,25,.72);display:flex;align-items:center;justify-content:center;padding:20px;font-family:-apple-system,BlinkMacSystemFont,sans-serif';
    d.innerHTML='<div style="background:#fff;border-radius:16px;padding:24px 22px;width:min(92vw,340px);box-shadow:0 10px 40px rgba(0,0,0,.3)"><h2 style="margin:0 0 6px;font-size:1.05rem;color:#16232b">Acceso familiar</h2><p style="margin:0 0 14px;font-size:.85rem;color:#5b6670;line-height:1.4">Introduzca la clave de la familia.</p><input id="ck-p" type="password" autocomplete="off" style="width:100%;padding:11px 12px;border:1px solid #cfd6db;border-radius:10px;font-size:16px;box-sizing:border-box"><p id="ck-e" style="margin:10px 0 0;font-size:.8rem;color:#a02020;min-height:1em"></p><button id="ck-b" style="margin-top:12px;width:100%;padding:12px;border:0;border-radius:10px;background:#0a6f6a;color:#fff;font-size:.95rem;font-weight:600">Entrar</button></div>';
    document.body.appendChild(d);
    var p=d.querySelector('#ck-p'),e=d.querySelector('#ck-e'),b=d.querySelector('#ck-b');
    function submit(){
      var v=p.value.trim();
      if(!v){e.textContent='Introduzca la clave';return}
      try{localStorage.setItem(K,v)}catch(err){}
      location.reload();
    }
    b.onclick=submit;
    p.onkeydown=function(ev){if(ev.key==='Enter')submit()};
    setTimeout(function(){p.focus()},50);
  }
  if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',gate)}else{gate()}
  var f=window.fetch;
  window.fetch=function(u,o){
    o=o||{};
    o.credentials='include';
    var h=new Headers(o.headers||{});
    var k=get();
    if(k){h.set('x-cuidar-key',k)}
    o.headers=h;
    return f.call(this,u,o).then(function(r){
      if(r&&r.status===401){try{localStorage.removeItem(K)}catch(e){}setTimeout(gate,0)}
      return r;
    });
  };
})();
const SUPABASE_URL = "https://guard.cuidaradistancia.com";
const SUPABASE_ANON_KEY = "sb_publishable_3RLMrZi5yuz9kxeAiMkSMw_y4foVtyu";
const ADMIN_PIN = "1234";
