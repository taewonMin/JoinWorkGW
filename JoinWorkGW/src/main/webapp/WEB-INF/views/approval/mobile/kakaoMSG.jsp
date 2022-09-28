<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>카톡 공유</title>
<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<button class="api-btn" onclick="getFriends()">친구 목록 가져오기</button>

<ul id="friend-list"></ul>

<a id="custom-login-btn" href="javascript:loginWithKakao()">
  <img
    src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
    width="222"
  />
</a>
<p id="token-result"></p>
<button class="api-btn" onclick="kakaoLogout()">로그아웃</button>

<a id="custom-login-btn" href="javascript:loginWithKakao()">
  <img
    src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
    width="222"
  />
</a>
<p id="token-result"></p>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script>

var myIp = '192.168.46.21';

Kakao.init('a82da43e6e33c2c5767d29498f8f24b6'); // 초기화

function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://'+myIp+'/JoinWorkGW/approval/kakaoMSG'
    })
  }
function kakaoLogout() {
    if (!Kakao.Auth.getAccessToken()) {
      alert('Not logged in.')
      return
    }
    Kakao.Auth.logout(function() {
      alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
    })
  }  
function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://'+myIp+'/JoinWorkGW/approval/kakaoMSG',
      prompts: 'login'
    })
  }
  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    const token = getCookie('reauthenticate-access-token')
    if(token) {
      Kakao.Auth.setAccessToken(token)
      Kakao.Auth.getStatusInfo(({ status }) => {
        if(status === 'connected') {
          document.getElementById('token-result').innerText = 'login success. token: ' + Kakao.Auth.getAccessToken()
        } else {
          Kakao.Auth.setAccessToken(null)
        }
      })
    }
  }
  function getCookie(name) {
    const value = "; " + document.cookie;
    const parts = value.split("; " + name + "=");
    if (parts.length === 2) return parts.pop().split(";").shift();
  }  
  
  
  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    const token = getCookie('authorize-access-token')
    if(token) {
      Kakao.Auth.setAccessToken(token)
      Kakao.Auth.getStatusInfo(({ status }) => {
        if(status === 'connected') {
          document.getElementById('token-result').innerText = 'login success. token: ' + Kakao.Auth.getAccessToken()
        } else {
          Kakao.Auth.setAccessToken(null)
        }
      })
    }
  }
  function getCookie(name) {
    const value = "; " + document.cookie;
    const parts = value.split("; " + name + "=");
    if (parts.length === 2) return parts.pop().split(";").shift();
  }

function sendMessage(id,title,url) {
    if (id != null) {
      Kakao.API.request({
        url: '/v1/api/talk/friends/message/default/send',
        data: {
          receiver_uuids: [id],
          template_object: {
            object_type: 'feed',
            content: {
              title: title,
              image_url: 'https://ifh.cc/g/1zZXIb.png',
              link: {
                mobile_web_url: url,
                web_url: url,
              },
            },
            buttons: [
              {
                title: '결재하러가기',
                link: {
                  mobile_web_url: url,
                  web_url: url
                },
              },
            ],
          },
        },
        success: function (res) {
//           alert('메시지 전송이 완료되었습니다. \n' + JSON.stringify(res))
        },
        fail: function (err) {
//           alert('메시지 전송에 실패했습니다. \n' + JSON.stringify(err))
        },
      })
    }
  }
  function getFriends() {
    document.getElementById('friend-list').innerHTML = ''
    Kakao.Auth.login({
      scope: 'friends,talk_message',
      success: function (res) {
        Kakao.API.request({
          url: '/v1/api/talk/friends',
          success: function (res) {
            if (res.elements.length > 0) {
              for (let i = 0, item; (item = res.elements[i]); i++) {
                const friendElement = document.createElement('li')
                const profileImg = item.profile_thumbnail_image
                  ? item.profile_thumbnail_image
                  : 'http://k.kakaocdn.net/dn/1xGCm/btqwLTjcNzV/orvxGiWth8JR20SgUcDNKK/kakaolink40_original.jpg'

                friendElement.innerHTML = '<div class="friend">'
                  + '<img src="' + profileImg + '">'
                  + '<strong>' + item.profile_nickname + '</strong>'
                  + '</div>'
                  + '<button onclick="sendMessage(\'' + item.uuid + '\')">전송</button>'
                document
                  .getElementById('friend-list')
                  .appendChild(friendElement)
              }
            } else {
              document.getElementById('friend-list').innerHTML =
                '앱에 연결된 친구가 없습니다. 앱에 연결된 친구만 조회할 수 있습니다.'
            }
          },
          fail: function (err) {
            document.getElementById('friend-list').innerHTML = JSON.stringify(err)
          },
        })
      },
    })
    
    
  }
















// try {
// 	var sendLinkDefault = function (approvalURL,title) {
	  
//     Kakao.init('d6e2987b244ff55f63af9ab2fe969378');
//     Kakao.Link.sendDefault({
//       objectType: 'feed',
//       content: {
//         title: 'JWGW',
//         description: '#결재문서',
//         imageUrl:"https://ifh.cc/g/1zZXIb.png",
        	
//         link: {
//           mobileWebUrl: 'http://192.168.46.15/JoinWorkGW/approval/waitDocDetail?docId=346',
//           webUrl: 'http://192.168.46.15/JoinWorkGW/approval/waitDocDetail?docId=346',
//         },
//       },
      
//       buttons: [
//         {
//           title: '결재하러가기',
//           link: {
//             mobileWebUrl: 'http://192.168.46.15/JoinWorkGW/approval/waitDocDetail?docId=346',
//             webUrl: 'http://192.168.46.15/JoinWorkGW/approval/waitDocDetail?docId=346'
//           },
//         },
//       ],
      
//     })
//   }
// ; window.kakaoDemoCallback && window.kakaoDemoCallback() }
// catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }

// console.log(sendLinkDefault);


</script>
   
</body>
</html>