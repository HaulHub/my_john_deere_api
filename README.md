# my\_john\_deer\_api

[![CircleCI](https://circleci.com/gh/Intellifarm/my_john_deere_api.svg?style=svg)](https://circleci.com/gh/Intellifarm/my_john_deere_api)

This client allows you to connect the [MyJohnDeere API](https://developer.deere.com/#!documentation)
without having to code your own oauth process, API requests, and pagination.

* Works with Rails, but does not require it
* Supports both sandbox and live mode
* Simplifies the oAuth negotiation process
* Provides an ActiveRecord-style interface to many endpoints
* Provides `get`, `create`, `put`, and `delete` methods to make easy, authenticated, direct API calls
* Uses ruby enumerables to handle pagination behind the scenes. Calls like `each`, `map`, etc will fetch new pages of data as needed.

## Documentation

We provide RDoc documentation, but here is a helpful guide for getting started. Because the gem name is long, all examples are going
to assume this shortcut:

```ruby
JD = MyJohnDeereApi
```

So that when you see:

```ruby
JD::Authorize
```
It really means:

```ruby
MyJohnDeereApi::Authorize
```

### Authorizing with John Deere via Auth 1.0

This is the simplest path to authorization, though your user has to jump through an extra hoop of giving you the verification code:

```ruby
# Create an authorize object, using your app's API key and secret. You can
# pass an environment (`:live` or `:sandbox`), which default to `:live`.
authorize = JD::Authorize.new(API_KEY, API_SECRET, environment: :sandbox)

# Retrieve a valid authorization url from John Deere, where you can send 
# your user for authorizing your app to the JD platform.
url = authorize.authorize_url

# Verify the code given to the user during the authorization process, and
# turn this into access credentials for your user.
authorize.verify(code)
```

In reality, you will likely need to re-instantiate the authorize object when the user returns, and that works without issue:

```ruby
# Create an authorize object, using your app's API key and secret.
authorize = JD::Authorize.new(API_KEY, API_SECRET, environment: :sandbox)

# Retrieve a valid authorization url from John Deere.
url = authorize.authorize_url

# Queue elevator music while your app serves other users...

# Re-create the authorize instance in a different process
authorize = JD::Authorize.new(API_KEY, API_SECRET, environment: :sandbox)

# Proceed as normal
authorize.verify(code)
```

In a web app, you're prefer that your user doesn't have to copy/paste verification codes. So you can pass in an :oauth_callback url.
When the user authorizes your app with John Deere, they are redirected to the url you provide, with the paraameter 'oauth_verifier'
that contains the verification code so the user doesn't have to provide it.

```ruby
# Create an authorize object, using your app's API key and secret.
authorize = JD::Authorize.new(
  API_KEY,
  API_SECRET,
  environment: :sandbox,
  oauth_callback: 'https://example.com'
)

# Retrieve a valid authorization url from John Deere.
# This will contain the callback url encoded into the
# query string for you.
url = authorize.authorize_url

# Queue elevator music while your app serves other users...

# Re-create the authorize instance in a different process.
# It's not necessary to re-initialize with the callback url.
authorize = JD::Authorize.new(API_KEY, API_SECRET, environment: :sandbox)

# Inside a Rails controller, you might do this:
authorize.verify(params[:oauth_verifier])
```

### Interacting with the user's John Deere account

After authorization is complete, the `Client` object will provide most of the interface for this library. A client can
be used with or without user credentials, because some API calls are specific to your application's relationship
with John Deere, not your user's. But most interactions will involve user data. Here's how to instantiate a client:

```ruby
client = JD::Client.new(
  # the application's API key
  API_KEY,

  # the application's API secret
  API_SECRET,

  # the chosen environment (:sandbox or :live)
  environment: :sandbox,

  # the user's access credentials
  access: [ACCESS_TOKEN, ACCESS_SECRET]
)
```


### Using the Client to Do Stuff

Once you're connected, the client works like a simplified version of ActiveRecord. JSON hashes from the API are
converted into objects to be easier to work with. Collections of things, like organizations, handle pagination
for you. Just iterate using `each`, `map`, etc, and new pages are fetched as needed.

This client is a work in progress. You can currently do the following things without resorting to API calls:

```
client
├── contribution_products
|   ├── count
|   ├── all
|   ├── first
|   └── find(contribution_product_id)
|       └── contribution_definitions
|           ├── count
|           ├── all
|           ├── first
|           └── find(contribution_definition_id)
└── organizations
    ├── count
    ├── all
    ├── first
    └── find(organization_id)
        ├── assets(attributes)
        |   ├── count
        |   ├── all
        |   ├── first
        |   ├── find(asset_id)
        |   |   └── locations
        |   |       ├── count
        |   |       ├── all
        |   |       ├── first
        |   |       └── create(attributes)
        |   └── create(attributes)
        └── fields
            ├── count
            ├── all
            ├── first
            └── find(field_id)
                └── flags
                    ├── count
                    ├── all
                    └── first
```


#### [Contribution Products](https://developer.deere.com/#!documentation&doc=.%2Fmyjohndeere%2Fproducts.htm)

Contribution Product collections act like a list. In addition to all the methods included via Ruby's
[Enumerable Module](https://ruby-doc.org/core-2.7.0/Enumerable.html), contribution product 
collections support the following methods:

* all
* count
* first
* find(contribution\_product\_id)

An individual contribution product supports the following methods and associations:

* id
* market_place_name
* market_place_description
* default\_locale
* current\_status
* activation\_callback
* preview\_images
* supported\_regions
* supported\_operation\_centers
* links
* contribution\_definitions (collection of this contribution product's contribution definitions)

```ruby
client.contribution_products
# => collection of contribution products under this client

client.contribution_products.count
# => 1

client.contribution_products.first
# => an individual contribution product

contribution_product = client.contribution_products.find(1234)
# => an individual contribution product, fetched by ID

contribution_product.market_place_name
# => 'Market Place Name'

contribution_product.contribution_definitions
# => collection of contribution definitions belonging to this contribution product
```


#### [Contribution Definitions](https://developer.deere.com/#!documentation&doc=.%2Fmyjohndeere%2Fproducts.htm)

Handles a contribution product's contribution definitions. Contribution definition collections support the following methods:

* all
* count
* first
* find(contribution\_definition\_id)

An individual contribution definition supports the following methods and associations:

* id
* name
* links

```ruby
contribution_product.contribution_definitions
# => collection of contribution definitions under this contribution product

client.contribution_definitions.count
# => 1

client.contribution_definitions.first
# => an individual contribution definition

contribution_definition = contribution_product.contribution_definitions.find(1234)
# => an individual contribution definition, fetched by ID

contribution_definition.name
# => 'Contribution Definition Name'
```


#### [Organizations](https://developer.deere.com/#!documentation&doc=myjohndeere%2Forganizations.htm)

Handles an account's organizations. Organization collections support the following methods:

* all
* count
* first
* find(organization\_id)

An individual organization supports the following methods and associations:

* id
* name
* type
* member?
* links
* assets (collection of this organization's assets)
* fields (collection of this organization's fields)

The `count` method only requires loading the first page of results, so it's a relatively cheap call. On the other hand,
`all` forces the entire collection to be loaded from John Deere's API, so use with caution. Organizations cannot be
created via the API, so there is no `create` method on this collection.

```ruby
client.organizations
# => collection of organizations under this client

client.organizations.count
# => 15

client.organizations.first
# => an individual organization object

organization = client.organizations.find(1234)
# => an individual organization object, fetched by ID

organization.name
# => 'Smith Farms'

organization.type
# => 'customer'

organization.member?
# => true

organization.links
# =>  {
#       'self' => 'https://sandboxapi.deere.com/platform/organizations/1234',
#       'machines' => 'https://sandboxapi.deere.com/platform/organizations/1234/machines',
#       'wdtCapableMachines' => 'ttps://sandboxapi.deere.com/platform/organizations/1234/machines?capability=wdt'   
#     }

organization.assets
# => collection of assets belonging to this organization

organization.fields
# => collection of fields belonging to this organization
```


#### [Assets](https://developer.deere.com/#!documentation&doc=.%2Fmyjohndeere%2Fassets.htm)

Handles an organization's assets. Asset collections support the following methods:

* all
* count
* first
* find(asset\_id)
* create(attributes)

An individual asset supports the following methods and associations:

* id
* title
* category
* type
* sub\_type
* links
* location (collection of this asset's locations)

```ruby
organization = client.organizations.first
# => the first organization returned by the client

organization.assets
# => collection of assets belonging to this organization

asset = organization.assets.find(123)
# => an individual asset object, fetched by ID

asset.title
# => 'AgThing Water Device'

asset.category
# => 'DEVICE'

asset.type
# => 'SENSOR'

asset.sub_type
# => 'OTHER'

asset.links
# => a hash of API urls related to this asset
```

Creating an asset requires a contribution\_definition\_id, in addition to the attributes listed in the
[John Deere API docs](https://developer.deere.com/#!documentation). This method creates the asset in
the John Deere platform, and returns the newly created record.

```ruby
asset = organization.assets.create(
  contribution_definition_id: ENV['CONTRIBUTION_DEFINITION_ID'],
  title: 'Asset Title',
  asset_category: 'DEVICE',
  asset_type: 'SENSOR',
  asset_sub_type: 'ENVIRONMENTAL'
)

asset.title
# => 'Asset Title'
```


### Direct API Requests

While the goal of the client is to eliminate the need to make/interpret calls to the John Deere API, it's important
to be able to make calls that are not yet fully supported by the client. Or sometimes, you need to troubleshoot.


#### GET


GET requests require only a resource path.

```ruby
client.get('/organizations')
```

Abbreviated sample response:

```json
{
  "links": ["..."],
  "total": 1,
  "values": [
    {
      "@type": "Organization",
      "name": "ABC Farms",
      "type": "customer",
      "member": true,
      "id": "123123",
      "links": ["..."]
    }
  ]
}
```

This won't provide any client goodies like pagination or validation, but it does parse the returned JSON.


#### POST

POST requests require a resource path, and a hash for the request body. The client will camelize the keys, and convert to JSON.

```ruby
client.post(
 '/organizations/123123/assets',
 {
   "title"=>"i like turtles",
   "assetCategory"=>"DEVICE",
   "assetType"=>"SENSOR",
   "assetSubType"=>"ENVIRONMENTAL",
   "links"=>[
     {
       "@type"=>"Link",
       "rel"=>"contributionDefinition",
       "uri"=>"https://sandboxapi.deere.com/platform/contributionDefinitions/CONTRIBUTION_DEFINITION_ID"
     }
    ]
  }
)
```

John Deere's standard response is a 201 HTTP status code, with the message "Created". This method returns the full Net::HTTP response.


#### PUT

PUT requests require a resource path, and a hash for the request body. The client will camelize the keys, and convert to JSON.

```ruby
client.put(
 '/assets/123123',
 {
   "title"=>"i REALLY like turtles",
   "assetCategory"=>"DEVICE",
   "assetType"=>"SENSOR",
   "assetSubType"=>"ENVIRONMENTAL",
   "links"=>[
     {
       "@type"=>"Link",
       "rel"=>"contributionDefinition",
       "uri"=>"https://sandboxapi.deere.com/platform/contributionDefinitions/CONTRIBUTION_DEFINITION_ID"
     }
    ]
  }
)
```

John Deere's standard response is a 204 HTTP status code, with the message "No Content". This method returns the full Net::HTTP response.


#### DELETE

DELETE requests require only a resource path.

```ruby
client.delete('/assets/123123')
```

John Deere's standard response is a 204 HTTP status code, with the message "No Content". This method returns the full Net::HTTP response.

### Contributing to This Gem

The easiest way to contribute is:

* Clone the repo
* Create a feature branch
* Grep for "raise NotYetImplementedError" in the lib directory
* Replace one of these exceptions with working code, following the conventions used in the rest of the app
* TEST EVERYTHING!
* Run tests.
  * You may need to regenerate all VCR cassettes from scratch.
  * All VCR cassettes should be pre-recorded in `vcr_setup`
  * Anything that is created in the JD sandbox as a result of running the tests should be removed, also in `vcr_setup`.
* When tests are passing, submit a Pull Request.