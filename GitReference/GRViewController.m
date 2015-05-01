//
//  GRViewController.m
//  GitReference
//
//  Created by Daniel Dayley on 4/27/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GRViewController.h"

static CGFloat margin = 15;
static CGFloat heightForLabel = 20;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";

@interface GRViewController ()

@end

@implementation GRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Get height and width of the view and build a standard GCRect (scrollViewRect) from it
    CGFloat frameWidth = CGRectGetWidth(self.view.frame);
    CGFloat frameHeight = CGRectGetHeight(self.view.frame);
    CGRect scrollViewRect = CGRectMake(0, 20, frameWidth, frameHeight);
    
    // Make a new view called scrollView
    CGSize contentScrollSize = CGSizeMake(frameWidth, frameHeight + 1000);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    [scrollView setContentSize:contentScrollSize];
    scrollView.frame = CGRectMake(0, 20, frameWidth, frameHeight);
    [self.view addSubview:scrollView];
    
    // Define variables for formatting our labels
    CGFloat topMargin = 20;
    CGFloat widthMinusMargin = self.view.frame.size.width - 2 * margin;
    CGFloat top = topMargin + heightForLabel + margin * 2;
    
    NSArray *commandReferenceArray = self.gitCommands;
    
    // Repeat in the viewController for each git command iin commandReferenceArray
    for (NSDictionary *gitCommand in commandReferenceArray) {
        

        NSString *theCommand = gitCommand[Command];
        NSString *theReference = gitCommand[Reference];
        
        // Render the name of the command and move our reference origin
        UILabel *gitCommand = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForLabel)];
        gitCommand.text = theCommand;
        [scrollView addSubview:gitCommand];
        top = (top + (heightForLabel + margin));
        
        // Render the information about the command and move our reference origin
        CGFloat heightForReference = [self heightOfReferenceString:theReference];
        UILabel *gitReference = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForReference)];
        gitReference.text = theReference;
        gitReference.numberOfLines = 0; // Allow the text to keep writing past it's ... point
        [scrollView addSubview:gitReference];
        top = (top + (heightForLabel + (margin * 2)));
        
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top);
                      
                      
    
    
}

- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}
- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
        options:NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
        context:nil];
    
    return bounding.size.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
