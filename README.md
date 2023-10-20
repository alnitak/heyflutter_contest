# HeyFlutter Challenge

A Flutter Coding Challenge with the Flutter community organized by [HeyFlutter.com](HeyFlutter.com)

Submit your Flutter project until 21. October: [Drible](https://forms.gle/o5fUjqJP22s9tmeg9)
by implementing this UI Challenge: [YouTube video](https://www.youtube.com/live/aERczKh_uMk?si=__FVuguyWIijgbva&t=546)

#### Packages used

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod) ©® by [Remi Rousselet](https://github.com/rrousselGit), is my choosen awesome state manager used with [riverpod_generator](https://pub.dev/packages/riverpod_generator)
- [freezed](https://pub.dev/packages/freezed) ©® by [Remi Rousselet](https://github.com/rrousselGit), for the plant data model
- [universal_io](https://pub.dev/packages/universal_io) ©® by [Dint](https://github.com/dint-dev), to use Platform on web
- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) ©® by [Romain Rastel](https://github.com/letsar), used for plants list page
- [Yoda](https://github.com/alnitak/yoda) my plugin for the favourite icon animation
- [StarMenu](https://github.com/alnitak/flutter_star_menu) my plugin to display cart drop down menu
- [magnifying_glass](https://github.com/alnitak/magnifying_glass) my plugin to have a magnifier in the plant details page

#### Notes 

- plant items are hard-coded into `models/dummy.dart`
- plant names, descriptions and short-descriptions are generated with the help of ChatGPT ;) and the plant images don't reflect their name and descriptions!
- in the dummy plant items "db", are stored all the images available to make a working scroll of the choosen plant in its details page. Instead of searching for many images of the same plant on the web, I preferred to do this for simplicity in this example.
- in the bottom left of plat details page, the sketch indicates a "Total Price" maybe to indicate the total cart price. This could puzzle the user when he press the "Add to Cart" button. Instead I show the current plant price and the total cart price is displayed in the drop down menu cart icon.
- the shader used in the plant detail page comes from https://www.shadertoy.com/view/4djGzz
- on desktop and web (not on the mobile browser) the Scaffold aspect ratio body has been fixed to 7/10
- on Android it is better to not open the app within the WebView but instead with the normal mobile browser


<table>
<tr>
	<td>onBoarding page</td>
	<td>search page</td>
	<td>details page</td>
</tr>
<tr>
	<td width=185 valign="top">
		<img width=185 src="https://github.com/alnitak/heyflutter_contest/assets/192827/2189b200-a823-4035-a0a1-226b1fe37f3c"></img>
	</td>
	<td width=185 valign="top">
		<img width=185 src="https://github.com/alnitak/heyflutter_contest/assets/192827/c1b6b16c-c2f2-4a57-ae1c-c907501d7120"></img>
	</td>
	<td width=185 valign="top">
		<img width=185 src="https://github.com/alnitak/heyflutter_contest/assets/192827/c74c4bda-6303-4469-a28d-efbc1ac6a5e6"></img>
	</td>
</tr>
</table>

[*try online*](https://marcobavagnoli.com/heyflutter_contest/)


*Where to reach me:*
<div id="badges">
  <a href="https://www.linkedin.com/in/marco-bavagnoli/"><img src="https://img.shields.io/badge/LinkedIn-blue?logo=linkedin" alt="LinkedIn Badge"/></a>
  <a href="https://www.youtube.com/@MarcoBavagnoli/videos"><img src="https://img.shields.io/badge/YouTube-red?logo=youtube&logoColor=white" alt="Youtube Badge"/></a>
  <a href="https://twitter.com/lildeimos"><img src="https://img.shields.io/badge/Twitter-blue?logo=twitter&logoColor=white" alt="Twitter Badge"/></a>
</div>

