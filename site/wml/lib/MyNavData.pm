package MyNavData;

my $hosts =
{
    'berlios' => 
    {
        'base_url' => "http://jmikmod.berlios.de/",
    },
};

my $tree_contents =
{
    'host' => "berlios",
    'text' => "MikMod for Java",
    'title' => "MikMod for Java - a multi-format Module Player for the Java Environment",
    'subs' =>
    [
        {
            'text' => "Home",
            'url' => "",
        },
        {
            'separator' => 1,
            'skip' => 1,
        },
        {
            'url' => "links/",
            'text' => "Links",
            'title' => "Related Links",
        },
    ],
};

my @rejects = 
(
        {
            'text' => "About",
            'url' => "about.html",
            'title' => "About this Site",
        },
        {
            'text' => "Download",
            'url' => "download/",
            'title' => "Download the code for the Site",
        },
        {
            'text' => "Mailing Lists",
            'url' => "mailing-lists/",
            'title' => "Discuss MikMod for Java with other people by E-mail.",
        },
);

sub get_params
{
    return 
        (
            'hosts' => $hosts,
            'tree_contents' => $tree_contents,
        );
}

1;
