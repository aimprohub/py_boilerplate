console.log("aap.js loaded");
// base.html required JS 
function myAction_vender(id) {
  document.getElementById("myForm").action = "/select_vender";
  document.getElementById("myForm").submit();
}
function myAction_dept() {
  document.getElementById("myForm").action = "/select_dept";
  document.getElementById("myForm").submit();
}
function myAction_logout() {
  document.getElementById("myForm").action = "/logout";
  document.getElementById("myForm").submit();
}
function myAction_post() {
  document.getElementById("myForm").action = "/postjason";
  document.getElementById("myForm").submit();
}

// parameter.html required JS functions

function show_no() {
  //document.getElementById("myForm").action = "/save_reading";
  var x = document.getElementById("myForm3").elements.length;
  var y = document.getElementById("myForm3").elements.item(4).value;
  var z = document.getElementById("myForm3").elements.namedItem("Remarks")
    .value;
  alert(x + y + z);
}
function getAllValues() {
  var x = document.getElementById("myForm");
  // console.log(x);
  alert("ok")
  var txt = "";
  var i;
  for (i = 0; i < x.length; i++) {
    txt = txt + x.elements[i].value + "|";
  }
  alert(txt);
  ////document.getElementById("myForm").element.namedItem("Remarks") = txt;
  document.getElementById("textall").value = txt;
  return txt;
}

function onChecked(element) {
  var checkbox = document.getElementById(element);
  checkbox.value = checkbox.checked == true ? "1" : "0"
}

function getFormData(){ 
  var elements = document.getElementById("myForm3").elements;
  var obj ={};
  for(var i = 0 ; i < elements.length ; i++){
    var item = elements.item(i);
    obj[item.name] = item.value;
  }
  var formData = JSON.stringify(obj); //if you want string from json object  
  // document.getElementById("final_obj").value = formData;
  alert(formData)
  return formData;
}

//Fun used in profile.html to validate date and other elements.
function validate_form() {
  alert ("in Validate")
            if (document.profile.address.value == "") {
                alert("Please fill in the 'Your address' box.");
                return false;
            }
            if (document.profile.aadhar_cd_no.value == "") {
                alert("Enter Aadhar Number");
                return false;
            }
            if (document.profile.dob.value == "") {
                alert("Enter Joining date");
                return false;
            }
          
            alert("sucessfully Submitted");
        }
 