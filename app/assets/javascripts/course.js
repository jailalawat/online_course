class Course {
  constructor(title, slug, price, description, short_description, free, primary_image_url, organisation, categories, images) {
    this.title = title;
    this.slug = slug;
    this.price = price;
    this.description = description;
    this.short_description = short_description;
    this.free = free;
    this.primary_image_url = primary_image_url;
    this.images = images;
    this.organisation = organisation;
    this.categories = categories;
  }

  indexPageListItem () {
    let html = "";
    html += `<div class="card">
              <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                <img
                  src="${this.primary_image_url}"
                  class="img-fluid"
                />
                <a href="#!">
                  <div class="mask" style="background-color: rgba(251, 251, 251, 0.15)"></div>
                </a>
              </div>
              <div class="card-body">
                <h5 class="card-title">${this.title}</h5>
                <p class="card-text">
                  ${this.description}
                </p>
                <a href="/courses/${this.slug}" class="btn btn-primary" target='_blank'>Show</a>
              </div>
            </div>`;
    return html;
  }

  showCourse () {
    let categories = '';
    this.categories.forEach( category => {
      categories += `${category.name}, `;
    });
    return `
          <h1 class="mt-4">${this.title}</h1>
          <p><strong>Organisation: </strong>${this.organisation.name}</p>
          <p><strong>Categories: </strong>${categories}</p>
          <img class="card-img-top" style='height:40%;' src="${this.primary_image_url}">

          <hr>

          <!-- Post Content -->
          <p class="lead">${this.description}</p>

          <p>${this.short_description}</p>

          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos, doloribus, dolorem iusto blanditiis unde eius illum consequuntur neque dicta incidunt ullam ea hic porro optio ratione repellat perspiciatis. Enim, iure!</p>
`
  }
}

function updateList(json) {
  const list = document.getElementById("courses");
  const pagination_number = $(".pagination .next_page");

  json['courses'].forEach( course => {
    const courseObj = new Course(course.title, course.slug, course.price, course.description, course.short_description, course.free, course.primary_image_url, course.organisation, course.categories, course.images);
    list.innerHTML += (courseObj.indexPageListItem());
  });
  pagination_number.html(`<a href="/courses?page=${json['next_page']}">Next</a>`);
}

function showCourse(course){
  const list = document.getElementById("course");

  const courseObj = new Course(course.title, course.slug, course.price, course.description, course.short_description, course.free, course.primary_image_url, course.organisation, course.categories, course.images);
  list.innerHTML += (courseObj.showCourse());
}

function updateCategory(categories){
  $.each(categories, function (index, value) {
    $('#category').append($('<option/>', {
        value: value['name'],
        text : value['name']
    }));
  });
}

$(document).ready(function(){
  $('#search').on('click', function(e){
    e.preventDefault();
    category = $('#category').val();
    provider = $('#provider').val();
    $.ajax({
      url: '/courses?category=' + category + '&provider=' + provider,
      method: 'GET',
      accept: 'json'
    }).success(function(data) {
      if(data['courses'] == ''){
        $('#courses').html('');
      }
      updateList(data)
    });
  })
});
