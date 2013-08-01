/**
 * @author Administrator
 */
function checkall (s,k){
   var a = document.getElementsByTagName('input'); 
   var n = a.length;
   for (var i=0; i<n; i++){
     if((a[i].type == "checkbox") && ( a[i].name.substr(0,k-1)==s )){ 
       a[i].checked = true;
     } 
   }
} 