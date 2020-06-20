// to make the first gov is empty, to force the user to chose a gov
// so that the event is triggered
let emptyGov = document.createElement('option');
emptyGov.value = -1;
emptyGov.text = 'Select Gov';
document.getElementById('select_gov').appendChild(emptyGov);

govs.forEach(gov => {
	let op = document.createElement('option');
	op.value = gov.id;
	op.text = gov.name;
	document.getElementById('select_gov').appendChild(op);
});

document.getElementById('select_gov').addEventListener('change', function () {

	let selectCityElement = document.getElementById('city_id');
	selectCityElement.style.display = 'inline';

	selectCityElement.innerHTML = '';
	let selectedGovId = parseInt(this.value);
	let govCities = cities.filter(city => city.governorate_id === selectedGovId);
	govCities.forEach(gov => {
		let singleCity = document.createElement('option');
		singleCity.value = gov.id;
		singleCity.text = gov.name;
		selectCityElement.appendChild(singleCity);
	});
});
